module SignIdentification_TB;
   reg thumb_status;
   reg index_status;
   reg middle_status;
   reg ring_status;
   reg pinky_status;

   wire [3:0] sign_value;

   reg 	clk,  rst;

   SignIdentification dut1 (.thumb_status(thumb_status),
			    .index_status(index_status),
			    .middle_status(middle_status),
			    .ring_status(ring_status),
			    .pinky_status(pinky_status),
			    .sign_value(sign_value),
			    .rst(rst), .clk(clk));

   always #5 clk = !clk;

   initial begin
      
      $dumpfile("vcddumps/SignIdentification_WF.vcd");
      $dumpvars(0, SignIdentification_TB);

      rst = 1'b1;
      clk = 1'b0;

      #10 rst = 1'b0;
      load_input(0,0,0,1,0);
      load_input(0,0,1,1,0);
      load_input(0,0,1,1,1);
      load_input(0,1,1,1,1);
      load_input(0,0,0,1,0);
      load_input(0,0,0,1,0);
      load_input(1,1,1,1,1);
      load_input(0,0,0,1,0);
      load_input(0,0,0,1,0);
      thumb_status=1;
      ring_status=1;
      middle_status=1;
      index_status=1;
      pinky_status=1;
      #10 $finish;
      
   end

   task load_input;
      /*
       load_input(pinky, ring, middle, index, thumb)
       */
      
      input _pinky_status;
      input _ring_status;
      input _middle_status;
      input _index_status;
      input _thumb_status;

      begin
	 @(posedge clk);
	 $display("Thumb = %b", _thumb_status);
	 $display("Index = %b", _index_status);
	 $display("Middle = %b", _middle_status);
	 $display("Ring = %b", _ring_status);
	 $display("Pinky = %b", _pinky_status);
	 thumb_status = _thumb_status;
	 index_status = _index_status;
	 middle_status = _middle_status;
	 ring_status = _ring_status;
	 pinky_status = _pinky_status;
	 @(negedge clk);
	 $display("Sign = %b", sign_value);
      end
   endtask // load_input
endmodule // SignIdentification_TB

	 
	 


	    
       