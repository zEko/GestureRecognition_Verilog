module BackgroundDifference(luma_bg, luma_sign,
			    object_image,
			    rst, clk);
   input [7:0] luma_bg, luma_sign;
   output      object_image;

   input       rst, clk;
   		    
   reg 	       object_image_temp;

   always @(posedge clk)
     if(rst)
       object_image = 0;
     else
       object_image = luma_bg xor  