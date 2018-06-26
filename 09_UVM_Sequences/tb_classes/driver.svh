`include "definitions.txt"
class driver extends uvm_driver #(sequence_item);
	`uvm_component_utils(driver)

	parameter int numPorts=`numPorts;
	
	virtual pds_bfm bfm;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(virtual pds_bfm)::get(null,"*","bfm",bfm))
			`uvm_fatal("DRIVER","Faild to get bfm");
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		sequence_item prs;
		bfm.reset_pds();
		forever begin : prs_loop
			bit [(numPorts-1):0] result;
			seq_item_port.get_next_item(prs);
			bfm.send_op(prs.det, prs.off, prs.prio,
				prs.pwr_bdj, prs.ports_off);
			prs.result=result;
			seq_item_port.item_done();
		end : prs_loop
	endtask : run_phase
endclass : driver
