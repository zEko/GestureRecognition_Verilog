module BackgroundDifference_TB;

   reg [7:0] luma_bg, luma_sign;
   reg 	     rst, clk;

   wire      object_image;

   BackgroundDifference dut_1(.luma_bg(luma_bg),
			      .luma_sign(luma_sign),
			      
				       

   always