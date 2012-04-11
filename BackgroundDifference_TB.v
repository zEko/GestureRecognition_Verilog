module BackgroundDifference_TB;

   reg [7:0] luma_bg, luma_sign;
   reg 	     rst, clk;

   wire      object_image;

   BackgroundDifference dut_1(.luma_bg(luma_bg),
			      .luma_sign(luma_sign),
			      .object_image(object_image),
			      .rst(rst),.clk(clk));
   
   always #10 clk = ~clk;

   initial
     begin

	clk = 1'b0;
	rst = 1'b1;

	#10 rst = 0;
	load_bd(100,100);
	load_bd(101,100);
	load_bd(100,100);
	load_bd(100,100);	
	#20 $finish;

     end // initial begin

   task load_bd;
      input [7:0] _luma_bg, _luma_sign;
      begin
	 @(posedge clk);
	 $display("\nBackground = %d, Sign_Capture = %d ", _luma_bg, _luma_sign);
	 luma_bg = _luma_bg;
	 luma_sign = _luma_sign;
	 @(posedge clk);
	 $display("Object_image = %b", object_image);
      end
   endtask // load_bd
endmodule // BackgroundDifference_TB

   