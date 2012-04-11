module SkinDecider(luma_ch, cb_ch, cr_ch,
		   skin_pix,
		   rst, clk);

   input [7:0] luma_ch, cb_ch, cr_ch;
   output      skin_pix;

   input 	rst, clk;

   reg  	skin_pix;

   always @(posedge clk) begin
      if (rst)
	 skin_pix = 0;
      else begin
	if ((luma_ch > 80) &&
	    (cb_ch > 125) && (cb_ch < 180) && 
	    (cr_ch > 190) && (cr_ch < 225))
	  skin_pix = 1;
	else
	  skin_pix = 0;
      end
   end // always @ (posedge clk)
endmodule // SkinDecider


	 
     
   
       