`timescale 1ns / 1ps

module lcd_pic(
    input wire clk_in,
    input wire sys_rst_n,
    input wire [9:0] pix_x,
    input wire [9:0] pix_y,
    output reg [23:0] pix_data
    );
    parameter INITIAL_POINT = 1;
    parameter BLUE = 24'h000FF;
    parameter PIC_SIZE = 400;
    
    reg [17:0] rd_addr;
    wire [23:0] rd_data;
    
    reg h_direct;
    reg v_direct;
    reg [9:0] pic_xp = INITIAL_POINT;
    reg [9:0] pic_yp = INITIAL_POINT;
    
    reg [24:0] mov_cnt;
    wire move_en;
    
    assign move_en = (mov_cnt == 1_000_000) ? 1'b1 : 1'b0;
     
     always @ (posedge clk_in or negedge sys_rst_n)begin
            if (~sys_rst_n)
                mov_cnt <= 'd0;
            else if ( mov_cnt < 1_000_000)
                mov_cnt <= mov_cnt + 1'b1;
            else
                mov_cnt <= 'd0;
       end
       
      always @ (posedge clk_in or negedge sys_rst_n)begin
            if(~sys_rst_n)begin
                h_direct <= 1'b1;
                v_direct <= 1'b1;
            end
            else begin
            //h
                if(pic_xp == 1)
                    h_direct <= 1'b1;
                else if (pic_xp == 800 - PIC_SIZE)
                    h_direct <= h_direct;
                    //v
                if(pic_yp == 1)
                    v_direct <= 1'b1;
                else if (pic_yp == 480 - PIC_SIZE)
                    v_direct <= 1'b0;
                else
                    v_direct <= v_direct;
            end
        end
             
       always @ (posedge clk_in or negedge sys_rst_n)begin
            if(~sys_rst_n)begin
                pic_xp <= 1'b1;
                pic_yp <= 1'b1;
            end
            else if(move_en)begin
                if(h_direct)
                    pic_xp <= pic_xp + 1'b1;
                else
                    pic_xp <= pic_xp - 1'b1;
                if(v_direct)
                    pic_yp <= pic_yp + 1'b1;
                else
                    pic_yp <= pic_yp - 1'b1;
             end
             else begin
                pic_xp <= pic_xp;
                pic_yp <= pic_yp;
             end
         end
         
     always @ (posedge clk_in or negedge sys_rst_n)begin
            if (~sys_rst_n)
                pix_data <= BLUE;
            else if ( (pix_x >= pic_xp && pix_x < pic_xp + PIC_SIZE) && (pix_y >= pic_yp && pix_y < pic_yp + PIC_SIZE) )
                pix_data <= rd_data;
            else 
                pix_data <= BLUE;

       end
       
      always @ (posedge clk_in or negedge sys_rst_n)begin
            if(~sys_rst_n)
                rd_addr <= 'd0;
            else if ( (pix_x >= pic_xp && pix_x < pic_xp + PIC_SIZE) && (pix_y >= pic_yp && pix_y < pic_yp + PIC_SIZE) )
                rd_addr <= rd_addr + 1'b1;
            else if(pix_y >= pic_yp + PIC_SIZE)
                rd_addr <= 'd0;
       end
             
      blk_mem_gen_0 blk_mem_gen_0_inst(
                                        .clka (clk_in),
                                        .addra (rd_addr),
                                        .douta (rd_data)
                                        );
       
