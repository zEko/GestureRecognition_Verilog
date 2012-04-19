module FingerIdentification(palm_width,
			    palm_height,
			    start_of_palm_r,
			    start_of_palm_c,
			    end_of_palm_r,
			    end_of_palm_c,
			    thumb_status,
			    index_status,
			    middle_status,
			    ring_status,
			    pinky_status,
			    rst,clk);
   
   input [7:0] palm_width, palm_height;
   input [7:0] start_of_palm_r, start_of_palm_c;
   input [7:0] end_of_palm_r, end_of_palm_c;

   output      thumb_status, index_status, middle_status, ring_status, pinky_status;

   input       rst, clk;

   reg      thumb_status, index_status, middle_status, ring_status, pinky_status;
   
   always @(posedge clk) begin
      if(rst) begin
	 thumb_status <= 0;
	 index_status <= 0;
	 middle_status <= 0;
	 ring_status <= 0;
	 pinky_status <= 0;
      end
      
      else begin
	 // The palm has been found, start calculating the fingers
	 if (palm_width != 0) begin
	    // Meanwhile keep track of the image row and columns
	    if(col_count == IMAGE_WIDTH) begin
	       // columns should not exceed image_width
	       col_count <= 0;
	       // increment row after 1 scan of column
	       row_count <= row_count + 1;
	    end
	    else begin
   	       col_count <= col_count + 1;
	    end
	    // Calculate the status of each finger
	 end
      end // else: !if(rst)
   end // always @ posedge(clk)
endmodule // FingerIdentification

	
	  
       
	
   

  
		    

		    
		    