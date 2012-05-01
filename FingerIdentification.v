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
   reg         thumb_status=0;
   reg 	       index_status=0;
   reg 	       middle_status=0;
   reg 	       ring_status=0;
   reg 	       pinky_status=0;
   
   // The dimensions of the image
   reg [7:0] 	IMAGE_WIDTH=120, IMAGE_HEIGHT=160;
   reg [7:0] 	row_count = 0, col_count = 0;
   
   // Threshold triggers
   reg [7:0]   pinky_true=0;
   reg [7:0]   ring_true=0;
   reg [7:0]   middle_true=0;
   reg [7:0]   index_true=0;
   reg [7:0]   thumb_true=0;
   
   // FInger boxes
   reg [7:0]   pinky_left = 0;
   reg [7:0]   pinky_right = 0;
   reg [7:0]   pinky_top = 0;
   reg [7:0]   pinky_bottom = 0;
   
   reg [7:0]   ring_left = 0;
   reg [7:0]   ring_right = 0;
   reg [7:0]   ring_top = 0;
   reg [7:0]   ring_bottom = 0;

   reg [7:0]   middle_left = 0;
   reg [7:0]   middle_right = 0;
   reg [7:0]   middle_top = 0;
   reg [7:0]   middle_bottom = 0;
   
   reg [7:0]   thumb_left = 0;
   reg [7:0]   thumb_right = 0;
   reg [7:0]   thumb_top = 0;
   reg [7:0]   thumb_bottom = 0;
   
   reg [7:0]   index_left = 0;
   reg [7:0]   index_right = 0;
   reg [7:0]   index_top = 0;
   reg [7:0]   index_bottom = 0;
   
   always @(posedge clk) begin
      if(rst) begin
         thumb_status <= 0;
         index_status <= 0;
         middle_status <= 0;
         ring_status <= 0;
         pinky_status <= 0;
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
               col_count <= col_count + 1;
         end
	 
	 // The palm has been found, start calculating the fingers
         if (palm_width != 0) begin
	    
	    // Create the Finger Boxes, The dimensions are similar to that of design in matlab.
            // Calculate the status of each finger.If the no.of white pixels in the finger's box
	    // exceeds the threshold, set its status
            pinky_left <= end_of_palm_c - (palm_width >> 2 ) + palm_width;
            pinky_right <= end_of_palm_c - (palm_width >> 2 );
            pinky_bottom <= end_of_palm_r + palm_height;
            pinky_top <= end_of_palm_r + palm_height + palm_height;	    
            if(row_count > pinky_bottom && row_count < pinky_top && col_count > pinky_right && col_count < pinky_left) begin
               if(object_image == 1) begin
                  pinky_true <= pinky_true + 1;
               end
               if(pinky_true > 200) begin
                  pinky_status <= 1;
               end
            end

            ring_left <= end_of_palm_c - (palm_width >> 2 ) - 3;
            ring_right <= start_of_palm_c + (palm_width >> 1) - 5;
            ring_bottom <= end_of_palm_r + palm_height;
            ring_top <= end_of_palm_r + palm_height + palm_height;	    
            if(row_count > ring_bottom && row_count < ring_top && col_count > ring_right && col_count < ring_left) begin            
               if(object_image == 1) begin
                  ring_true <= ring_true + 1;
               end
               if(ring_true > 250) begin
                  ring_status <= 1;
               end
            end

            middle_left <= start_of_palm_c + (palm_width >> 1) - 5 - 7;
            middle_right <=  start_of_palm_c + (palm_width >> 1) - 5 - 7 - (palm_width >> 1);
            middle_bottom <= end_of_palm_r + palm_height;
            middle_top <= end_of_palm_r + palm_height + palm_height;	    
            if(row_count > middle_bottom && row_count < middle_top && col_count > middle_right && col_count < middle_left) begin                    
               if(object_image == 1) begin
                  middle_true <= middle_true + 1;
               end
               if(middle_true > 250) begin
                  middle_status <= 1;
               end
            end
            
            index_left <= start_of_palm_c + (palm_width >> 1) - 5 - 7 - (palm_width >> 1);
            index_right <= start_of_palm_c + (palm_width >> 1) - 5 - 7 - (palm_width >> 1) - palm_width;
            index_bottom <= end_of_palm_r + palm_height;	    
            index_top <= end_of_palm_r + palm_height + palm_height;
            if(row_count > index_bottom && row_count < index_top && col_count > index_right && col_count < index_left) begin
               if(object_image == 1) begin
                  index_true <= index_true + 1;
               end
               if(index_true > 250) begin
                  index_status <= 1;
               end
            end
            
            thumb_left <= start_of_palm_c - 10;
            thumb_right <= start_of_palm_c - 10 - palm_height;
            thumb_bottom <= start_of_palm_r;
            thumb_top <= start_of_palm_r + 30;
            if(row_count > thumb_bottom && row_count < thumb_top && col_count > thumb_right && col_count < thumb_left) begin      
               if(object_image == 1) begin
                  thumb_true <= thumb_true + 1;
               end
               if(thumb_true > 250) begin
                  thumb_status <= 1;
               end
            end
         end // if (palm_width != 0)
      end // else: !if(rst)
   end // always @ (posedge clk)
endmodule // FingerIdentification

