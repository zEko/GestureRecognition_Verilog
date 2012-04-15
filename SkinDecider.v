module SkinDecider(luma_ch, cb_ch, cr_ch,
		   object_image,
		   rst, clk);

   input [7:0] luma_ch, cb_ch, cr_ch;
   output      object_image;

   input 	rst, clk;

   reg  	object_image;

   always @(posedge clk) begin
      if (rst)
	 object_image = 0;
      else begin
	if ((luma_ch > 80) &&
	    (cb_ch > 125) && (cb_ch < 180) && 
	    (cr_ch > 190) && (cr_ch < 225))
	  object_image = 1;
	else
	  object_image = 0;
      end
   end // always @ (posedge clk)
endmodule // SkinDecider


	 
     
   
       