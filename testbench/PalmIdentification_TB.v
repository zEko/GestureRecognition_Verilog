module PalmIdentification_TB;

   reg object_image, TESTING_SWITCH;
   reg [7:0] palm_height_test;
   	     
   wire [7:0] start_of_palm_r, start_of_palm_c, end_of_palm_r, end_of_palm_c, palm_height, palm_width;

   reg 	      rst, clk;

   integer    object_image_fd;
   integer    some_var;
   

   PalmIdentification dut1 (.object_image(object_image),
			    .palm_height_test(palm_height_test),
			    .TESTING_SWITCH(TESTING_SWITCH),
			    .start_of_palm_r(start_of_palm_r),
			    .start_of_palm_c(start_of_palm_c),
			    .end_of_palm_r(end_of_palm_r),
			    .end_of_palm_c(end_of_palm_c),
			    .palm_width(palm_width),
			    .palm_height(palm_height),
			    .rst(rst), .clk(clk));

   always #5 clk = !clk;

   initial begin

      $dumpfile("vcddumps/PalmIdentification_WF.vcd");
      $dumpvars(0, PalmIdentification_TB);
      
      rst = 1'b0;
      clk = 1'b0;

      object_image_fd = $fopen("data/object_image.txt", "r");

      while(!$feof(object_image_fd)) begin
	 @(posedge clk);
	 some_var = $fscanf(object_image_fd, "%d\n", object_image);
      end

      $fclose(object_image_fd);
      
      #10 $finish;
   end
endmodule // PalmIdentification_TB

	 
      
	
		

	

   
