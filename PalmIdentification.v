module PalmIdentification(object_image,
			  palm_height_test,
			  start_of_palm_r,
			  start_of_palm_c,
			  end_of_palm_r,
			  end_of_palm_c,
			  palm_width,
			  palm_height,
			  TESTING_SWITCH,			  
			  rst,clk);
   /*
    Finds the centre of the bottom of palm.
    
    INPUT:
    object_image - 1 bit, hand sign image.
    palm_height_test : 8 bit, value of pal height obtained from testing mode
    
    OUTPUT:
    start_of_palm_r : 8 bit, row index of start of palm
    start_of_palm_c : 8 bit, column index of start of palm
    end_of_palm_r : 8 bit, row index of end of palm
    end_of_palm_c : 8 bit, column index of end of palm
    palm_width : 8 bit, calculated palm_width
    palm_height : 8 bit, calculated palm_height
    
    FLAG:
    TESTING_SWITCH : To use the palm_height_test value.
    */
    
   
   // The 'object_image' is received after segmentation
   // if TESTING_SWITCH is set, the palm height is manually entered
   input object_image;
   input [7:0] palm_height_test;
   output [7:0] start_of_palm_r, start_of_palm_c, end_of_palm_r, end_of_palm_c, palm_height, palm_width;
   input 	TESTING_SWITCH;
   input 	rst, clk;
   
   reg [7:0] 	start_of_palm_r, start_of_palm_c, end_of_palm_r, end_of_palm_c, palm_height, palm_width;
   // A flag to check if the entire first line is received
   reg 		FOUND_PALM_START=0, FOUND_PALM_END=0;
   // The dimensions of the image
   reg [7:0] 	IMAGE_WIDTH=120, IMAGE_HEIGHT=160;
   reg [7:0] 	row_count = 0, col_count = 0;
   // flag to indicate 'break out of id mode'
   reg 		INNERBREAK = 0;
   
   
   always @(posedge clk) begin
      if (rst) begin
	 start_of_palm_r <= 8'b0;
	 start_of_palm_c <= 8'b0;
	 end_of_palm_r <= 8'b0;
	 end_of_palm_c <= 8'b0;
	 palm_width <= 8'b0;
	 palm_height <= 8'b0;
      end

      else begin
	 // Keep track of the image row and columns
	 if(col_count >= IMAGE_WIDTH-1) begin
	    // columns should not exceed image_width
	    col_count <= 0;
	    // increment row after 1 scan of column
	    row_count <= row_count + 1;
	 end
	 else begin
	    // still in the same column
   	    col_count <= col_count + 1;
	 end
	 
	 // If palm has been found ignore the incoming pixels
	 if(INNERBREAK == 1) begin
	 end
	 
	 // palm not found
	 else begin
	    // found hand pixel
	    if(object_image) begin
	       // check if the start of palm has been found
	       if(FOUND_PALM_START == 0) begin
		  // if not mark it as the start of palm
		  FOUND_PALM_START <= 1;
		  // record the row and column values
		  start_of_palm_r <= row_count;
		  start_of_palm_c <= col_count;
	       end // if(FOUND_PALM_START)
	       else begin
		  // if the start has been found mark it as the end
		  // record the row and column values
		  end_of_palm_r <= row_count;
		  end_of_palm_c <= col_count;
		  // Mark that the end of palm has been found
		  FOUND_PALM_END <= 1;
	       end // !if(FOUND_PALM_START)
	    end // if (object_image)
	       
            // If its not a hand pixel
	    else begin
	       if(FOUND_PALM_END == 1) begin
		  palm_width <= end_of_palm_c - start_of_palm_c;
		  if (palm_width > 17) begin
		     // Stop accepting the incoming pixels
		     INNERBREAK <= 1;
		     // Calculate palm height
		     if(!TESTING_SWITCH) begin
			// Non testing mode
			palm_height <= palm_width * 1.5;
		     end //if(!TESTING_SWITCH)
		     else begin
			// Testing mode
			palm_height <= palm_height_test;
		     end // !if(!TESTING_SWITCH)
		  end // if (palm_width > 17)
		  else begin
		     // reset the palm id flags
		     FOUND_PALM_START  <= 0;
		     FOUND_PALM_END <= 0;
		  end // else: !if(palm_width > 17)
	       end // if (FOUND_PALM_END == 1)
	    end // else: !if(object_image)
	 end // else: !if(INNERBREAK == 1)
      end // else: !if(rst)
   end // always @ (posedge clk)
endmodule // PalmIdentification

