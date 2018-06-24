`include "definitions.txt"
package pds_pkg;
   import uvm_pkg::*;
   `include "uvm_macros.svh"
   parameter int numPorts=`numPorts;


	typedef struct packed{
		logic [(numPorts-1):0] det;
   		logic [(numPorts-1):0] off;
   		logic [(numPorts-1):0] on;
		logic [(2*numPorts-1):0] prio;
   		logic [7:0] pwr_bdj;
   		logic ports_off;} prs_s;//Power Receive System transaction

   	`include "coverage.svh"
   	`include "base_tester.svh"
   	`include "random_tester.svh"
   	`include "cpwr_tester.svh"   
   	`include "scoreboard.svh"
	`include "driver.svh"
	`include "prs_monitor.svh"
	`include "result_monitor.svh"
   	`include "env.svh"
  	`include "random_test.svh"
  	`include "cpwr_test.svh"
   
endpackage : pds_pkg
