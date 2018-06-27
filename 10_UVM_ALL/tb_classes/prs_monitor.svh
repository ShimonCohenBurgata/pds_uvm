class prs_monitor extends uvm_component;
	`uvm_component_utils(prs_monitor)

	
	virtual pds_bfm bfm;
	
	uvm_analysis_port #(sequence_item) ap;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		pds_agent_config pds_agent_config_h;
		if(!uvm_config_db #(pds_agent_config)::get(this,"","config",pds_agent_config_h))
			`uvm_fatal("PRS_MONITOR","Faild to get bfm");
		bfm=pds_agent_config_h.bfm;

		
		ap=new("ap", this);
	endfunction : build_phase

	function void connect_phase(uvm_phase phase);
		bfm.prs_monitor_h=this;
	endfunction : connect_phase

	function void write_to_monitor(	bit [(numPorts-1):0] idet, bit [(numPorts-1):0] ioff,
					bit [(2*numPorts-1):0] iprio, bit [7:0] ipwr_bdj,
					bit iports_off, bit[(numPorts-1):0] ion);
		
		sequence_item prs;
 		`uvm_info("COMMAND MONITOR",$sformatf("MONITOR: det: %h  off: %h  prio: %h pwr_bdj: %h ports_off: %h, on: %h",
                idet, ioff, iprio, ipwr_bdj, iports_off, ion), UVM_HIGH);
		prs=new("prs");
		prs.det=idet;
		prs.off=ioff;
		prs.prio=iprio;
		prs.pwr_bdj=ipwr_bdj;
		prs.ports_off=iports_off;
		prs.result=ion;
		ap.write(prs);
	endfunction : write_to_monitor
endclass : prs_monitor
