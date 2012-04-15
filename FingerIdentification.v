module FingerIdentification(palm_width,
e			    palm_height,
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

   always @posedge(clk) begin
     if(rst) begin
	thumb_status = 0;
	index_status = 0;
	middle_status = 0;
	ring_status = 0;
	pinky_status = 0;
     end

     else begin
	if (palm_width != 0) begin
	   // Calculate the status of each finger
	end
     end // else: !if(rst)
   end // always @ posedge(clk)
endmodule // FingerIdentification

	
	  
       
	
   

  
		    

		    
		    