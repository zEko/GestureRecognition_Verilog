/* Author : Kai
   Software : iverilog
   License : LGPL
*/

module RGBtoYCbCr_TB;

   //Define all inputs as registers
   reg rst = 1'b1;
   reg clk = 1'b0;
   reg [7:0] red_ch ;
   reg [7:0] green_ch ;
   reg [7:0] blue_ch ;

   //Define all outputs as wires
   wire [7:0] luma_ch;
   wire [7:0] cb_ch;
   wire [7:0] cr_ch;

   //Instantiate the rgb2y module
   RGBtoYCbCr dut1( .red_ch(red_ch), 
			  .green_ch(green_ch),
			  .blue_ch(blue_ch),
			  .luma_ch(luma_ch),
			  .cb_ch(cb_ch),
			  .cr_ch(cr_ch),
			  .clk(clk),
			  .rst(rst));

   // Clock
   always #5 clk = !clk;
   
   // The simulation stimulus   
   initial begin

      // VCD for gtkwave
      $dumpfile("debug_wf.vcd");
      $dumpvars(0,RGBtoYCbCr_TB); // $dumpvars(?, module_name)

      clk = 1'b0; // At time = 0
      rst = 1'b1; // Active low reset
      
      $monitor("Luma = %d, Cb = %d, Cr = %d ", 
	       luma_ch, cb_ch, cr_ch);

      #10 rst = 0;
      load_RGB(111,3,122);
      load_RGB(121,3,2);
      load_RGB(211,123,2);
      load_RGB(1,123,12);
      load_RGB(21,1,12);
      load_RGB(11,13,122);
      #20 $finish;
   end // initial begin

   task load_RGB;
      input [7:0] r_ch, g_ch, b_ch;
      begin
	 @(posedge clk); // Activate only on posedge of clk
	 $display("\nRed = %d, Green = %d, Blue = %d", r_ch, g_ch, b_ch);
	 red_ch = r_ch;
	 green_ch = g_ch;
	 blue_ch = b_ch;
      end
   endtask // load_RGB
endmodule // RGBtoYCbCr_TB

