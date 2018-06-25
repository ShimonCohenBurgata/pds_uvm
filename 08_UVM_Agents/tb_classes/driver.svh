class driver extends uvm_component;
	`uvm_component_utils(driver)

	virtual pds_bfm bfm;

	uvm_get_port #(prs_transaction) prs_port;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		pds_agent_config pds_agent_config_h;
		if(!uvm_config_db #(pds_agent_config)::get(this,"","config",pds_agent_config_h))
			`uvm_fatal("DRIVER","Faild to get bfm");
		bfm=pds_agent_config_h.bfm;
		prs_port=new("prs_port",this);

	endfunction : build_phase

	task run_phase(uvm_phase phase);
		prs_transaction prs;
		bfm.reset_pds();
		forever begin : prs_loop
			prs_port.get(prs);
			bfm.send_op(prs.det, prs.off, prs.prio,
				prs.pwr_bdj, prs.ports_off);
		end : prs_loop
	endtask : run_phase
endclass : driver