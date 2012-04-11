module SkinDecider_TB;

   reg [7:0] luma_ch, cb_ch, cr_ch;
   reg rst, clk;

   wire skin_pix;

   SkinDecider dut_1(.luma_ch(luma_ch),
		     .cb_ch(cb_ch),
		     .cr_ch(cr_ch),
		     .skin_pix(skin_pix),
		     .clk(clk),
		     .rst(rst));

   always #5 clk = !clk;
   
   initial begin
      clk = 1'b0;
      rst = 1'b1;

      $dumpfile("debug_wf.vcd");
      $dumpvars(0,SkinDecider_TB);
      
      #5 rst = 0;
      load_YCbCr(123,145,190);
      load_YCbCr(0,0,0);
      load_YCbCr(250,150,200);
      load_YCbCr(123,167,200);
      load_YCbCr(123,167,00);
      load_YCbCr(123,177,230);
      load_YCbCr(0,0,0);      
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
	 $display("Skin = %b", skin_pix);
      end
   endtask // load_YCbCr

endmodule // SkinDecider_TB


      
     