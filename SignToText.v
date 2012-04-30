module SignToText(red_ch,
		  green_ch,
		  blue_ch,
		  palm_height_test,
		  BACKGROUND_DIFFERENCE,
		  clk,rst);
   /*
    Top level module
    
    INPUT:
    red_ch - 8 bit, red component of image.
    green_ch - 8 bit, green component of image.
    blue_ch - 8 bit, blue component of image.
    palm_height_test - 8 bit, height of palm obtained from testing.
    
    FLAG:
    BACKGROUND_DIFFERENCE - Method of hand segmentation
    */
    
   input [7:0] red_ch, green_ch, blue_ch;
   input [7:0] palm_height_test;
   input       BACKGROUND_DIFFERENCE;
      
   input       clk, rst;
   
   // Am i doing it right
   wire        rst, clk;
   
   // Need a training mode switch
   wire [7:0]  palm_height_test;
   wire [7:0]  luma_ch, cb_ch, cr_ch;
   RGBtoYCbCr dut_0 (.red_ch(red_ch),
		     .green_ch(green_ch),
		     .blue_ch(blue_ch),
		     .luma_ch(luma_ch),
		     .cb_ch(cb_ch),
		     .cr_ch(cb_ch),
		     .rst(rst),
		     .clk(clk));
   
   wire        object_image;
   SkinDecider dut_1 (.luma_ch(luma_ch),
		      .cb_ch(cb_ch),	
		      .cr_ch(cr_ch),
		      .object_image(object_image),
		      .BACKGROUND_DIFFERENCE(BACKGROUND_DIFFERENCE),
		      .rst(rst), .clk(clk));
   
   wire [7:0]  start_of_palm_c, start_of_palm_r;
   wire [7:0]  end_of_palm_c, end_of_palm_r;
   wire [7:0]  palm_height, palm_width;
   PalmIdentification dut_2 (.object_image(object_image),
			     .palm_height_test(palm_height_test),
			     .start_of_palm_r(start_of_palm_r),
			     .start_of_palm_c(start_of_palm_c),
			     .end_of_palm_r(end_of_palm_r),
			     .end_of_palm_c(end_of_palm_c),
			     .palm_width(palm_width),
			     .palm_height(palm_height),
			     .TESTING_SWITCH(TESTING_SWITCH),
			     .rst(rst),.clk(clk));
   
   wire        thumb_status, index_status, middle_status, ring_status, pinky_status;
   FingerIdentification dut_3 (.object_image(object_image),
			       .palm_width(palm_width),
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
   
   wire [3:0]  sign_value;
   SignIdentification dut_4(.thumb_status(thumb_status),
			    .index_status(index_status),
			    .middle_status(middle_status),
			    .ring_status(ring_status),
			    .pinky_status(pinky_status),
			    .sign_value(sign_value),
			    .rst(rst),.clk(clk));
   
endmodule // SignToText


   
			       
