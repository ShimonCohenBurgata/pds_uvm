`include "definitions.txt"
class coverage extends uvm_test;
	`uvm_component_utils(coverage)

	virtual pds_bfm bfm;
	parameter int numPorts=`numPorts;
	
	bit [(numPorts-1):0] det;
	bit [(numPorts-1):0] off;
	bit [(2*numPorts-1):0] prio;
	bit [7:0] pwr_bdj;
	bit ports_off;

	covergroup cov;
		cdet : coverpoint det;
		coff : coverpoint off;
		cprio: coverpoint prio;
		cpwr_bdj: coverpoint pwr_bdj;
		cross det, off;
	endgroup : cov


	function new(string name, uvm_component parent);
		super.new(name, parent);
		cov=new();
	endfunction : new

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(virtual pds_bfm)::get(null, "*", "bfm", bfm))
			$fatal(1,"Faild to get BFM");
	endfunction : build_phase
	
	task run_phase(uvm_phase phase);
		forever begin : sampling_block
			@(negedge bfm.clk);
			det=bfm.det;
			off=bfm.off;
			prio=bfm.prio;
			pwr_bdj=bfm.pwr_bdj;
			ports_off=bfm.ports_off;
			cov.sample();
		end : sampling_block
	endtask : run_phase

endclass : coverage
