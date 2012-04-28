module FingerIdentification(object_image,
			    palm_width,
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
   
   input object_image;
   input [7:0] palm_width, palm_height;
   input [7:0] start_of_palm_r, start_of_palm_c;
   input [7:0] end_of_palm_r, end_of_palm_c;

   output      thumb_status, index_status, middle_status, ring_status, pinky_status;

   input       rst, clk;

   // Finger status indicators,
   // if open, status is `True`
   // else status is `False`
   reg      thumb_status, index_status, middle_status, ring_status, pinky_status;
   
   // The dimensions of the image
   reg 		IMAGE_WIDTH=160, IMAGE_HEIGHT=120;
   reg 		row_count = 0, col_count = 0;

   // Threshold triggers
   reg [7:0] pinky_true=0;
   reg [7:0] ring_true=0;
   reg [7:0] middle_true=0;
   reg [7:0] index_true=0;
   reg [7:0] thumb_true=0;

   // FInger boxes
   reg [7:0] pinky_left = 0;
   reg [7:0] pinky_right = 0;
   reg [7:0] pinky_top = 0;
   reg [7:0] pinky_bottom = 0;
   
   reg [7:0] ring_left = 0;
   reg [7:0] ring_right = 0;
   reg [7:0] ring_top = 0;
   reg [7:0] ring_bottom = 0;

   reg [7:0] middle_left = 0;
   reg [7:0] middle_right = 0;
   reg [7:0] middle_top = 0;
   reg [7:0] middle_bottom = 0;
   
   reg [7:0] thumb_left = 0;
   reg [7:0] thumb_right = 0;
   reg [7:0] thumb_top = 0;
   reg [7:0] thumb_bottom = 0;
   
   reg [7:0] index_left = 0;
   reg [7:0] index_right = 0;
   reg [7:0] index_top = 0;
   reg [7:0] index_bottom = 0;
   
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
	    // If the no.of white pixels in the finger's box
	    // exceeds the threshold, set its status

	    pinky_left <= 0;
	    pinky_right <= 0;
	    pinky_top <= 0;
	    pinky_bottom <= 0;
	    if(row_count > pinky_bottom && row_count < pinky_top && col_count > pinky_left && col_count < pinky_right) begin
	       if(object_image == 1) begin
		  pinky_true <= pinky_true + 1;
	       end
	       if(pinky_true > 100) begin
		  pinky_status <= 1;
	       end
	    end

	    ring_left <= 0;
	    ring_right <= 0;
	    ring_top <= 0;
	    ring_bottom <= 0;
	    if(row_count > ring_bottom && row_count < ring_top && col_count > ring_left && col_count < ring_right) begin	    
	       if(object_image == 1) begin
		  ring_true <= ring_true + 1;
	       end
	       if(ring_true > 100) begin
		  ring_status <= 1;
	       end
	    end

	    middle_left <= 0;
	    middle_right <= 0;
	    middle_top <= 0;
	    middle_bottom <= 0;
	    if(row_count > middle_bottom && row_count < middle_top && col_count > middle_left && col_count < middle_right) begin	      	    
	       if(object_image == 1) begin
		  middle_true <= middle_true + 1;
	       end
	       if(middle_true > 100) begin
		  middle_status <= 1;
	       end
	    end
	    
	    index_left <= 0;
	    index_right <= 0;
	    index_top <= 0;
	    index_bottom <= 0;
	    if(row_count > index_bottom && row_count < index_top && col_count > index_left && col_count < index_right) begin
	       if(object_image == 1) begin
		  index_true <= index_true + 1;
	       end
	       if(index_true > 100) begin
		  index_status <= 1;
	       end
	    end
	    
	    thumb_left <= 0;
	    thumb_right <= 0;
	    thumb_top <= 0;
	    thumb_bottom <= 0;
	    if(row_count > thumb_bottom && row_count < thumb_top && col_count > thumb_left && col_count < thumb_right) begin	  
	       if(object_image == 1) begin
		  thumb_true <= thumb_true + 1;
	       end
	       if(thumb_true > 100) begin
		  thumb_status <= 1;
	       end
	    end
	 end // if (palm_width != 0)
      end // else: !if(rst)
   end // always @ (posedge clk)
endmodule // FingerIdentification




