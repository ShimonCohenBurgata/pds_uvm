`include "definitions.txt"
package pds_pkg;
   import uvm_pkg::*;
   `include "uvm_macros.svh"
   parameter int numPorts=`numPorts;

	`include "sequence_item.svh"
	`include "cpwr_sequence_item.svh"
	 typedef uvm_sequencer #(sequence_item) sequencer;
	`include "random_sequence.svh"
	`include "cpwr_sequence.svh"
	
   	`include "env_config.svh"
	`include "pds_agent_config.svh"
	`include "result_transaction.svh"
   	`include "coverage.svh"
	`include "scoreboard.svh"
	`include "driver.svh"
	`include "prs_monitor.svh"
	`include "result_monitor.svh"
	`include "pds_agent.svh"


   	`include "env.svh"
	`include "pds_base_test.svh"
	`include "random_test.svh"
	`include "cpwr_test.svh"

endpackage : pds_pkg
