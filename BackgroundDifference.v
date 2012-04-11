module BackgroundDifference(luma_bg, luma_sign,
			    object_image,
			    rst, clk);
   input [7:0] luma_bg, luma_sign;
   output      object_image;

   input       rst, clk;
   		    
   reg 	       object_image;

   always @(posedge clk) begin
     if(rst)
       object_image = 0;
     else
       object_image = luma_bg ^ luma_sign;
   end
endmodule // BackgroundDifference

   
   