module PalmIdentification(object_image,
			  palm_height_test,
			  TESTING_SWITCH,
			  start_of_palm_r,
			  start_of_palm_c,
			  end_of_palm_r,
			  end_of_palm_c,
			  palm_width,
			  palm_height,
			  rst,clk);
   
   // The 'object_image' is received after segmentation
   // if TESTING_SWITCH is set, the palm height is manually entered
   input object_image, TESTING_SWITCH;
   input [7:0] palm_height_test;
   output [7:0] start_of_palm_r, start_of_palm_c, end_of_palm_r, end_of_palm_c, palm_height, palm_width;
   input 	rst, clk;
   
   reg [7:0] 	start_of_palm_r, start_of_palm_c, end_of_palm_r, end_of_palm_c, palm_height, palm_width;
   // A flag to check if the entire first line is received
   reg 		FOUND_PALM_START=0, FOUND_PALM_END=0;
   reg 		IMAGE_WIDTH=160, IMAGE_HEIGHT=120;
   reg 		row_count = 0, col_count = 0;
   // flag to indicate 'break out of id mode'
   reg 		INNERBREAK = 0;
   
   
   always @(posedge clk) begin
      if (rst) begin
	 start_of_palm_r = 8'b0;
	 start_of_palm_c = 8'b0;
	 end_of_palm_r = 8'b0;
	 end_of_palm_c = 8'b0;
	 palm_width = 8'b0;
	 palm_height = 8'b0;
      end

      else begin
	 // If palm has been found ignore the incoming pixels
	 if(INNERBREAK == 1) begin
	 end
	 
	 // palm not found
	 else begin
	    // reset the palm id flags
	    FOUND_PALM_START  = 0;
	    FOUND_PALM_END = 0;

	    // found hand pixel
	    if(object_image) begin
	       // check if the start of palm has been found
	       if(FOUND_PALM_START == 0) begin
		  // if not mark it as the start of palm
		  FOUND_PALM_START = 1;
		  // record the row and column values
		  start_of_palm_r = row_count;
		  start_of_palm_c = col_count;
	       end // if(FOUND_PALM_START)
	       else begin
		  // if the start has been found mark it as the end
		  // record the row and column values
		  end_of_palm_r = row_count;
		  end_of_palm_c = col_count;
		  // Mark that the end of palm has been found
		  FOUND_PALM_END = 1;
	       end // !if(FOUND_PALM_START)
	    end // if (object_image)
	       
            // If its not a hand pixel
	    else begin
	       if(FOUND_PALM_END == 1) begin
		  palm_width = end_of_palm_c - start_of_palm_c;
		  if (palm_width > 17) begin
		     // Stop accepting the incoming pixels
		     INNERBREAK = 1;
		     // Calculate palm height
		     if(!TESTING_SWITCH) begin
			// Non testing mode
			palm_height = palm_width * 1.5;
		     end //if(!TESTING_SWITCH)
		     else begin
			// Testing mode
			palm_height = palm_height_test;
		     end // !if(!TESTING_SWITCH)
		  end // if (palm_width > 17)
	       end // if (FOUND_PALM_END == 1)
	    end // else: !if(object_image)
	 end // else: !if(INNERBREAK == 1)
	 
	 // Meanwhile keep track of the image row and columns
	 if(col_count == IMAGE_WIDTH) begin
	    // columns should not exceed image_width
	    col_count = 0;
	    // increment row after 1 scan of column
	    row_count = row_count + 1;
	 end
	 else begin
   	    col_count = col_count + 1;
	 end
      end // else: !if(rst)
   end // always @ (posedge clk)
endmodule // PalmIdentification

