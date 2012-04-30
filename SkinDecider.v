module SkinDecider(luma_ch, cb_ch, cr_ch,
		   object_image,
		   BACKGROUND_DIFFERENCE,
		   rst, clk);
   /*
    If background_difference method is not used, extract the 
    skin pixels from the incoming input image. Otherwise sutract 
    image from the background reference.
    
    INPUT:
    luma_ch - 8 bit, background(one time) and image.
    
    OUTPUT:
    object_image - 1 bit hand sign image
    
    FLAG:
    BACKGROUND_DIFFERENCE - Method of hand segmentation
   */
    
   input [7:0] luma_ch, cb_ch, cr_ch;
   input       BACKGROUND_DIFFERENCE;
   
   output      object_image;

   input 	rst, clk;

   reg  	object_image;
   reg 		BACKGROUND_SCAN_COMPLETE;
   reg [15:0] 	counter=0;
   reg [7:0] 	luma_bg[0:19199];
   
   always @(posedge clk) begin
      if (rst)
	object_image <= 0;
      else begin

	 // if we are using the background difference method
	 if(BACKGROUND_DIFFERENCE) begin
	    // check if the scan is complete
	    if(BACKGROUND_SCAN_COMPLETE) begin
	       if ((luma_bg[counter] - luma_ch < 20) || (luma_ch - luma_bg[counter] < 20))
		 object_image <= 1'b1;
	       else
		 object_image <= 1'b0;
	       counter <= counter + 1;
	    end

	    // Store the background luma pixels, the first image captured
	    else begin
	       luma_bg[counter] <= luma_ch;
	       // Do not overflow the counter
	       if(counter == 19200) begin
		  BACKGROUND_SCAN_COMPLETE <= 1;
		  // set counter to 0, for the comparision step
		  counter <= 0;
	       end
	       else
		 counter <= counter + 1;
	    end
	 end // if (BACKGROUND_DIFFERENCE)
	 else if ((luma_ch > 80) &&
		  (cb_ch > 125) && (cb_ch < 180) && 
		  (cr_ch > 190) && (cr_ch < 225)) begin
	    object_image <= 1;
	 end
	 else begin
	    object_image <= 0;
	 end
      end
   end // always @ (posedge clk)
endmodule // SkinDecider


	 
     
   
       