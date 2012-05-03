module SignToText_TB;

   reg object_image;
   reg [7:0] palm_height_test;

   wire [3:0] sign_value;

   reg 	      clk, rst;
   
   reg 	      TESTING_SWITCH;

   integer    object_image_fd, some_var;
   
   SignToText dut_10(.object_image(object_image),
		     .palm_height_test(palm_height_test),
		     .sign_value(sign_value),
		     .TESTING_SWITCH(TESTING_SWITCH),
		     .rst(rst), .clk(clk));

   always #5 clk = !clk;

   initial begin
      clk = 1'b0;
      rst = 1'b0;

      $dumpfile("vcddumps/SignToText_WF.vcd");
      $dumpvars(0, SignToText_TB);

      object_image_fd = $fopen("data/object_image.txt", "r");

      TESTING_SWITCH = 1;
      palm_height_test = 39;
      
      while(!$feof(object_image_fd)) begin
	 @(posedge clk);
	 some_var = $fscanf(object_image_fd, "%d\n", object_image);

      end

      $fclose(object_image_fd);

      #10 $finish;
   end // initial begin
endmodule // SignToText_TB


	 
	
	