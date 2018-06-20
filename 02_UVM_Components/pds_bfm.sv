/* Bus Functional Model */
`include "definitions.txt"
interface pds_bfm;
   parameter int numPorts=`numPorts;
   logic [(numPorts-1):0] det;
   logic [(numPorts-1):0] off;
   logic [(numPorts-1):0] on;
   logic [(2*numPorts-1):0] prio;
   logic [7:0] pwr_bdj;
   logic ports_off;
   logic rst_n;
   logic clk;

   task reset_pds();
	   rst_n = 1'b0;
	   @(negedge clk);
	   @(negedge clk);
	   rst_n = 1'b1;
   endtask : reset_pds

   task send_op(input bit [(numPorts-1):0] idet, input bit [numPorts-1:0] ioff,
	   input bit [(2*numPorts-1):0] iprio, input [7:0] ipwr_bdj, input iports_off);
   	@(posedge clk);
	det=idet;
	off=ioff;
	prio=iprio;
	pwr_bdj=ipwr_bdj;
	ports_off=iports_off;
   endtask : send_op

   initial begin
      clk =1'b0;
      forever begin
	 #10;
	 clk = ~clk;	 
      end
   end

endinterface : pds_bfm



