module SignIdentification(thumb_status,
			    index_status,
			    middle_status,
			    ring_status,
			    pinky_status,
			    sign_value,
			    rst,clk);
   
   input      thumb_status, index_status, middle_status, ring_status, pinky_status;

   output [3:0] sign_value;

   input 	rst, clk;

   always @posedge(clk) begin
      if(rst) begin
	 sign_value = 4'b0000;
      end

      else begin
	 // if we can individually set bit based on position
	 // we could possibly use case
	 // But how
      end
   end // always @ posedge(clk)
endmodule // FingerIdentification

   
	 
   
   
