`timescale 1ns / 1ps

module lcd_pic(
    input wire clk_in,
    input wire sys_rst_n,
    input wire [9:0] pix_x,
    input wire [9:0] pix_y,
    output reg [23:0] pix_data
    );
    parameter RED = 24'hFF0000,
              ORANGE = 24'hFFA500,
              YELLOW = 24'hFFFF00,
              GREEN = 24'h008000,
              CYAN = 24'h00FFFF,
              BLUE = 24'h0000FF,
              PURPLE = 24'h800080,
              BLACK = 24'h000000,
              WHITE = 24'hFFFFFF,
              GRAY = 24'hBEBEBE;
     parameter H_VALID = 800;
     
     always @ (posedge clk_in or negedge sys_rst_n)
        if(sys_rst_n == 1'b0)
            pix_data <= 24'd0;
        else if ((pix_x >= 0) && (pix_x < (H_VALID/10)*1))
            pix_data <= RED;
        else if ((pix_x >= (H_VALID/10)*1) && (pix_x < (H_VALID/10)*2))
            pix_data <= ORANGE;
        else if ((pix_x >= (H_VALID/10)*2) && (pix_x < (H_VALID/10)*3))
            pix_data <= YELLOW;
        else if ((pix_x >= (H_VALID/10)*3) && (pix_x < (H_VALID/10)*4))
            pix_data <= GREEN;  
        else if ((pix_x >= (H_VALID/10)*4) && (pix_x < (H_VALID/10)*5))
            pix_data <= CYAN;
        else if ((pix_x >= (H_VALID/10)*5) && (pix_x < (H_VALID/10)*5))
            pix_data <= BLUE;
        else if ((pix_x >= (H_VALID/10)*6) && (pix_x < (H_VALID/10)*6))
            pix_data <= PURPLE;
        else if ((pix_x >= (H_VALID/10)*7) && (pix_x < (H_VALID/10)*7))
            pix_data <= BLACK;
        else if ((pix_x >= (H_VALID/10)*8) && (pix_x < (H_VALID/10)*8))
            pix_data <= WHITE;
        else if ((pix_x >= (H_VALID/10)*9) && (pix_x < H_VALID))
            pix_data <= GRAY;
        else
            pix_data <= BLACK;
           
endmodule
