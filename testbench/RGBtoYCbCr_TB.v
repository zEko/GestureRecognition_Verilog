/*
 
 Author: Kai
 License: If u can push one, its GPL
 
 */

module RGBtoYCbCr_TB;

   reg [7:0] red_ch, green_ch, blue_ch;
   
   wire [7:0] luma_ch, cb_ch, cr_ch;

   reg 	     rst, clk;

   integer   red_fd, green_fd, blue_fd;
   integer   some_var_r, some_var_g, some_var_b;

   RGBtoYCbCr dut1(.red_ch(red_ch),
		   .green_ch(green_ch),
		   .blue_ch(blue_ch),
		   .luma_ch(luma_ch),
		   .cb_ch(cb_ch),
		   .cr_ch(cr_ch),
		   .rst(rst), .clk(clk));
   
   always #5 clk = !clk;

   initial begin

      $dumpfile("vcddumps/RGBtoYcbCr_Wf.vcd");
      $dumpvars(0, RGBtoYCbCr_TB);
      
      rst = 1'b0;
      clk = 1'b0;

      red_fd = $fopen("data/red_ch.txt", "r");
      green_fd = $fopen("data/green_ch.txt", "r");
      blue_fd = $fopen("data/blue_ch.txt", "r");

      while (!$feof(red_fd) || !$feof(green_fd) || !$feof(blue_fd)) begin
	 @(posedge clk);
 	 some_var_r = $fscanf(red_fd, "%d\n", red_ch);
	 some_var_g = $fscanf(green_fd, "%d\n", green_ch);
	 some_var_b = $fscanf(blue_fd, "%d\n", blue_ch);
	 
      end
            
      $fclose(red_fd);
      $fclose(green_fd);
      $fclose(blue_fd);

      #20 $finish;
      
   end // initial begin
endmodule // RGBtoYCbCr_TB

     
      
      
	 
	 
	 
  
   

       
   