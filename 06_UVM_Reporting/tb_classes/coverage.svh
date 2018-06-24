`include "definitions.txt"
class coverage extends uvm_subscriber #(prs_s);
	`uvm_component_utils(coverage)

	parameter int numPorts=`numPorts;
	
	bit [(numPorts-1):0] det;
	bit [(numPorts-1):0] off;
	bit [(2*numPorts-1):0] prio;
	bit [7:0] pwr_bdj;
	bit ports_off;
	bit [(numPorts-1):0] on;

	covergroup cov;
		cdet : coverpoint det;
		coff : coverpoint off;
		cprio: coverpoint prio;
		cpwr_bdj: coverpoint pwr_bdj;
		con:coverpoint on;
		cross det, off;
	endgroup : cov


	function new(string name, uvm_component parent);
		super.new(name, parent);
		cov=new();
	endfunction : new

	function void write(prs_s t);
		det=t.det;
		off=t.off;
		prio=t.prio;
		pwr_bdj=t.pwr_bdj;
		ports_off=t.ports_off;
		on=t.on;
		cov.sample();
	endfunction:write


endclass : coverage
