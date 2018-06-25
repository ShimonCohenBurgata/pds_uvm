`include "definitions.txt"
package pds_pkg;
   import uvm_pkg::*;
   `include "uvm_macros.svh"
   parameter int numPorts=`numPorts;


	`include "prs_transaction.svh"
	`include "cpwr_transaction.svh"
	`include "result_transaction.svh"
   	`include "coverage.svh"
   	`include "tester.svh"
   	`include "scoreboard.svh"
	`include "driver.svh"
	`include "prs_monitor.svh"
	`include "result_monitor.svh"

   	`include "env.svh"

  	`include "random_test.svh"
  	`include "cpwr_test.svh"
   
endpackage : pds_pkg
