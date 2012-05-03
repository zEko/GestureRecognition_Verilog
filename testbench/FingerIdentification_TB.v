module FingerIdentification_TB;
   
   reg object_image;
   reg [7:0] palm_width, palm_height;
   reg [7:0] start_of_palm_r, start_of_palm_c;
   reg [7:0] end_of_palm_r, end_of_palm_c;
   
   wire      thumb_status, index_status, middle_status, ring_status, pinky_status;
   
   reg       rst, clk;

   integer   object_image_fd, some_var;

   FingerIdentification dut_1(.object_image(object_image),
                              .palm_width(palm_width),
                              .palm_height(palm_height),
                              .start_of_palm_r(start_of_palm_r),
                              .start_of_palm_c(start_of_palm_c),
                              .end_of_palm_r(end_of_palm_r),
                              .end_of_palm_c(end_of_palm_c),
                              .thumb_status(thumb_status),
                              .index_status(index_status),
                              .middle_status(middle_status),
                              .ring_status(ring_status),
                              .pinky_status(pinky_status),
                              .rst(rst), .clk(clk));

   always #5 clk = !clk;

   initial begin

      $dumpfile("vcddumps/FingerIndentification_WF.vcd");
      $dumpvars(0, FingerIdentification_TB);
      
      clk = 1'b0;
      rst = 1'b0;
      palm_width = 32;
      palm_height = 39;
      start_of_palm_r = 10;
      start_of_palm_c = 78;
      end_of_palm_r = 10;
      end_of_palm_c = 110;
      
      object_image_fd = $fopen("data/object_image.txt", "r");
      
      while(!$feof(object_image_fd)) begin
	 @(posedge clk);
	 some_var = $fscanf(object_image_fd, "%d\n", object_image);
      end

      $fclose(object_image_fd);

      #10 $finish;
   end // initial begin
endmodule // FingerIdentification

      
   

   