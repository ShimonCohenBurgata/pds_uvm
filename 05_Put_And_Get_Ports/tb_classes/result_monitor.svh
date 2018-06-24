`include "definitions.txt"
class result_monitor extends uvm_component;
	`uvm_component_utils(result_monitor)

	parameter int numPorts=`numPorts;

	
	uvm_analysis_port #(bit [(numPorts-1):0]) ap;


	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);

		virtual pds_bfm bfm;

		if(!uvm_config_db #(virtual pds_bfm)::get(null, "*", "bfm", bfm))
			$fatal(1, "Faild to get bfm");
		
		bfm.result_monitor_h=this;
		
		ap=new("ap", this);


	endfunction : build_phase

	function void write_to_monitor(	bit [(numPorts-1):0] ion);
		
		bit [(numPorts-1):0] on;
		on=ion;
		ap.write(on);
	
	endfunction : write_to_monitor




endclass : result_monitor
