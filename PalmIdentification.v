module PalmIdentification(object_image,
			  palm_height_test,
			  TESTING_SWITCH,
			  palm_left,
			  palm_right,
			  palm_height,);
   
   input object_image, TESTING_SWITCH;
   input [7:0] palm_height_test;

   output [7:0] palm_left, palm_right, palm_height;

   input 	rst, clk;

   reg [7:0] 	palm_left, palm_right, palm_height;
   reg 		READY=0;
   
   initial begin
      // IF the first line of image is recieved begin
      READY = 1;
   end

   always @(posedge clk) begin
      if (rst) begin
	 palm_left = 8'b0;
	 palm_right = 8'b0;
	 palm_height = 8'b0;
      end
      else begin
	if(READY) begin
	  // DO the stuff
	end
	else begin
	  // Skip the line
	end
      end // else: !if(rst)
   end // always @ (posedge clk)
endmodule // PalmIdentification

      
   