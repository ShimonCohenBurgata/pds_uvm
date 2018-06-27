`include "definitions.txt"
class pds_agent extends uvm_agent;
	`uvm_component_utils(pds_agent)
	pds_agent_config pds_agent_config_h;

   	sequencer       sequencer_h;
  	driver          driver_h;
   	scoreboard      scoreboard_h;
   	coverage        coverage_h;
   	prs_monitor 	prs_monitor_h;
   	result_monitor  result_monitor_h;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		sequencer_h=new("sequencer_h", this);

		if(!uvm_config_db #(pds_agent_config)::get(this,"","config",pds_agent_config_h))
			`uvm_fatal("AGENT","Failed to get config object");
		is_active=pds_agent_config_h.get_is_active();

		if(get_is_active()==UVM_ACTIVE) begin:make_stimulus
			driver_h=driver::type_id::create("driver_h",this);
		end : make_stimulus

		prs_monitor_h=prs_monitor::type_id::create("prs_monitor_h",this);
		result_monitor_h=result_monitor::type_id::create("result_monitor_h",this);

		coverage_h=coverage::type_id::create("coverage_h",this);
		scoreboard_h=scoreboard::type_id::create("scoreboard_h",this);

	endfunction : build_phase

	function void connect_phase(uvm_phase phase);
		driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
	
		prs_monitor_h.ap.connect(coverage_h.analysis_export);
		prs_monitor_h.ap.connect(scoreboard_h.prs_f.analysis_export);
		result_monitor_h.ap.connect(scoreboard_h.analysis_export);

	endfunction : connect_phase
endclass : pds_agent
