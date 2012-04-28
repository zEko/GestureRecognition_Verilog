/* Author : Kai
   Software : iverilog
   License : LGPL
*/
   
module RGBtoYCbCr(red_ch, green_ch, blue_ch,
		  luma_ch, cb_ch, cr_ch,
		  clk, rst);
   // inputs: R,G,B are 8 bit values with 0~255 range
   // outputs: Y, Cb, Cr is a 8 bit number, range 0~255

   input rst;
   input clk;
   input [7:0] red_ch;
   input [7:0] green_ch;
   input [7:0] blue_ch;

   output [7:0] luma_ch;
   output [7:0] cb_ch;
   output [7:0] cr_ch;
      
   reg [7:0] luma_ch;
   reg [7:0] cb_ch;
   reg [7:0] cr_ch;
   
   // Normalization coeffecients
   parameter NC_red = 77;
   parameter NC_blue = 29;
   parameter NC_green = 150;
   
   always @(posedge clk)
   begin: RGB_to_YCbCr
     if (rst) begin //active low reset
      luma_ch <= 0; // set all registers to 0 during reset
      cb_ch <= 0;
      cr_ch <= 0;
     end
     else begin
      luma_ch <= (NC_red*red_ch) + (NC_green*green_ch) + (NC_blue*blue_ch);
      cb_ch <= 0;
      cr_ch <= 0;
     end
   end // block: RGB_to_YCbCr
endmodule // RGBtoYCbCr

   