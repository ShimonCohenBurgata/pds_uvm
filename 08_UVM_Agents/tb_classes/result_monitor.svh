`include "definitions.txt"
class result_monitor extends uvm_component;
	`uvm_component_utils(result_monitor)

	parameter int numPorts=`numPorts;

	virtual pds_bfm bfm;
	
	uvm_analysis_port #(result_transaction) ap;


	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		pds_agent_config pds_agent_config_h;
		if(!uvm_config_db #(pds_agent_config)::get(this, "", "config", pds_agent_config_h))
			`uvm_fatal("RESULT_MONITOR", "Faild to get config");
		pds_agent_config_h.bfm.result_monitor_h=this;
		ap=new("ap", this);
	endfunction : build_phase

	function void write_to_monitor(	bit [(numPorts-1):0] ion);
		result_transaction result_t;
		result_t=new("result_t");
		result_t.result=ion;
		ap.write(result_t);
	endfunction : write_to_monitor
endclass : result_monitor
