`timescale 1ns / 1ps

module lcd_pic(
    input wire clk_in,
    input wire sys_rst_n,
    input wire [9:0] pix_x,
    input wire [9:0] pix_y,
    output reg [23:0] pix_data
    );
    reg [17:0] rd_addr;
    wire  [23:0] rd_data;
    
    parameter BLUE = 24'h000FF;
    parameter YELLOW = 24'hFFFF00;
    parameter GREEN = 24'h008000;
    parameter PIC_SIZE = 400;
     
     always @ (posedge clk_in or negedge sys_rst_n)begin
            if (~sys_rst_n)
                pix_data <= BLUE;
            else if ( (pix_x >= 100 && pix_x < 100 + PIC_SIZE) && (pix_y >= 40 && pix_y < 40 + PIC_SIZE) )
                pix_data <= rd_data;
            else if ( (pix_x >= 700 && pix_x < 800) && (pix_y >= 450 && pix_y < 480) )
                pix_data <= GREEN;
            else
                pix_data = BLUE;
       end
       
      always @ (posedge clk_in or negedge sys_rst_n)begin
            if (~sys_rst_n)
                rd_addr <= 'd0;
            else if ( (pix_x >= 99 && pix_x < 99 + PIC_SIZE) && (pix_y >= 39 && pix_y < 39 + PIC_SIZE) )
                rd_addr <= rd_addr + 1'b1;
            else if (pix_y > 440)
                rd_addr <= 'd0;
       end
       
      blk_mem_gen_0 blk_mem_gen_0_inst(
                                        .clka (clk_in),
                                        .addra (rd_addr),
                                        .douta (rd_data)
                                        );
       
           
endmodule
