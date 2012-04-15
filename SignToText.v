module SignToText(red_ch,
		  green_ch,
		  blue_ch,
		  palm_height_test,
		  clk,rst);

   input [7:0] red_ch, green_ch, blue_ch;
   input clk, rst;

   // Am i doing it right
   wire  rst, clk;

   // Need a training mode switch
   reg 	 [7:0] palm_height_test;
   

   wire [7:0] luma_ch, cb_ch, cr_ch;
   wire [7:0] luma_bg, luma_sign;
   wire       object_image;
   
   RGBtoYCbCr dut_1 (.red_ch(red_ch),
		     .green_ch(green_ch),
		     .blue_ch(blue_ch),
		     .luma_ch(luma_ch),
		     .cb_ch(cb_ch),
		     .cr_ch(cb_ch),
		     .rst(rst),
		     .clk(clk));

   BackgroundDifference dut_2 (.luma_bg(luma_ch),
			       .luma_sign(luma_sign),
			       .object_image(object_image),
			       .rst(rst),
			       .clk(clk));

   PalmIdentification dut_3 (.object_image(object_image),
			     .palm_height_test(palm_height_test),
			     .TESTING_SWITCH(TESTING_SWITCH),
			     .start_of_palm_r(start_of_palm_r),
			     .start_of_palm_r(start_of_palm_c),
			     .end_of_palm_r(end_of_palm_r),
			     .end_of_palm_r(end_of_palm_c),
			     .palm_width(palm_width),
			     .palm_height(palm_height),
			     .rst(rst),.clk(clk));

   FingerIdentification dut_4 (.palm_width(palm_width),
			       .palm_height(palm_height),
			       .start_of_palm_r(start_of_palm_r),
			       .start_of_palm_c(start_of_palm_c),
			       .end_of_palm_r(end_of_palm_r),
			       .end_of_palm_c(end_of_palm_c),
			       .thumb_status(thumb_status),
			       .index_status(index_status),
			       .middle_status(middle_status),
			       .ring_status(ring_status),
			       .pinky_status(pinky_status),
			       .rst(rst),.clk(clk));

   SignIdentification dut_5(.thumb_status(thumb_status),
			    .index_status(index_status),
			    .middle_status(middle_status),
			    .ring_status(ring_status),
			    .pinky_status(pinky_status),
			    .sign_value(sign_value),
			    .rst(rst),.clk(clk));

endmodule // SignToText





   
			       
