`include "definitions.txt"
package pds_pkg;
   import uvm_pkg::*;
   `include "uvm_macros.svh"
   parameter int numPorts=`numPorts;

	`include "sequence_item.svh"
	 typedef uvm_sequencer #(sequence_item) sequencer;

	 //`include "cpwr_sequence.svh"
	 `include "random_sequence.svh"

	`include "result_transaction.svh"
   	`include "coverage.svh"
   	`include "scoreboard.svh"
	`include "driver.svh"
	`include "prs_monitor.svh"
	`include "result_monitor.svh"

   	`include "env.svh"
	`include "pds_base_test.svh"
	`include "random_test.svh"

endpackage : pds_pkg
