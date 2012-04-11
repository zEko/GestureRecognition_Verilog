/* Author : Kai
   Software : iverilog
   License : LGPL
*/
// R,G,B are 8 bit values with 0~255 range
// Y is a 8 bit number, range 0~255
//
// Conversion Equation
// Y = 0.299*R + 0.587*G + 0.114*B
//
// Normalization equations
// Y = (1/256) * [256*0.299*R + 256*0.587*G + 256*0.114*B]
// Y = (1/256) * [76.544*R + 150.272*G + 29.184*B]
// Y = (1/256) * [77*R + 150*G + 29*B]
//
   
module RGBtoYCbCr(red_ch, green_ch, blue_ch,
		       luma_ch, cb_ch, cr_ch,
		       clk, rst);
   // 8 bit pixel
   parameter WIDTH=8;

   input rst;
   input clk;
   input [WIDTH-1:0] red_ch;
   input [WIDTH-1:0] green_ch;
   input [WIDTH-1:0] blue_ch;

   output [WIDTH-1:0] luma_ch;
   output [WIDTH-1:0] cb_ch;
   output [WIDTH-1:0] cr_ch;
      
   reg [WIDTH-1:0] luma_ch;
   reg [WIDTH-1:0] cb_ch;
   reg [WIDTH-1:0] cr_ch;
   
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
      luma_ch = (NC_red*red_ch) + (NC_green*green_ch) + (NC_blue*blue_ch);
      cb_ch = 0;
      cr_ch = 0;
     end
   end // block: RGB_to_YCbCr
endmodule // RGBtoYCbCr

   