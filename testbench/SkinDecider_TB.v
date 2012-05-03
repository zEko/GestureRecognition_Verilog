module SkinDecider_TB;

   reg [7:0] luma_ch, cb_ch, cr_ch;
   reg 	     BACKGROUND_DIFFERENCE;
   reg rst, clk;
   
   reg [7:0] luma_bg[0:3];
   
   wire      object_image;
   
   SkinDecider dut_1(.luma_ch(luma_ch),
		     .cb_ch(cb_ch),
		     .cr_ch(cr_ch),
		     .object_image(object_image),
		     .BACKGROUND_DIFFERENCE(BACKGROUND_DIFFERENCE),
		     .clk(clk),
		     .rst(rst));

   always #5 clk = !clk;
   
   initial begin
      clk = 1'b0;
      rst = 1'b0;

      $dumpfile("vcddumps/SkinDecider_WF.vcd");
      $dumpvars(0,SkinDecider_TB);
      
      BACKGROUND_DIFFERENCE = 1;
      load_YCbCr(123,145,190);
      load_YCbCr(125,0,0);
      load_YCbCr(135,150,200);
      load_YCbCr(123,167,200);
      load_YCbCr(124,167,00);
      load_YCbCr(125,177,230);
      load_YCbCr(0,0,0);
      load_YCbCr(250,150,200);
      load_YCbCr(121,167,200);
      load_YCbCr(122,167,00);
      load_YCbCr(125,177,230);

      #20 $finish;

   end // initial begin
     
   task load_YCbCr;
      input [7:0] _luma_ch, _cb_ch, _cr_ch;
      begin
	 @(posedge clk); // Activate only on posedge of clk
	 $display("\nLuma = %d, Cb = %d, Cr = %d", _luma_ch, _cb_ch, _cr_ch);
	 luma_ch = _luma_ch;
	 cb_ch = _cb_ch;
	 cr_ch = _cr_ch;
	 @(posedge clk);
	 $display("Skin = %b", object_image);
      end
   endtask // load_YCbCr
endmodule // SkinDecider_TB


      
     