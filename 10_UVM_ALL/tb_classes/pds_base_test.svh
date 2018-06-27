virtual class pds_base_test extends uvm_test;
	`uvm_component_utils(pds_base_test)

	env env_h;
	sequencer sequencer_h;

	function new (string name, uvm_component parent);
      		super.new(name,parent);
   	endfunction : new

	function void build_phase(uvm_phase phase);
		virtual pds_bfm class_bfm;
		env_config env_config_h;

		if(!uvm_config_db #(virtual pds_bfm)::get(this,"","class_bfm",class_bfm))
			`uvm_fatal("DUAL_TEST","Failed to get class_bfm");

		env_config_h=new(.class_bfm(class_bfm));

		uvm_config_db #(env_config)::set(this,"env_h*","config",env_config_h);

		env_h=env::type_id::create("env_h",this);

	endfunction : build_phase

	function void end_of_elaboration_phase(uvm_phase phase);
      		sequencer_h = env_h.class_pds_agent_h.sequencer_h;
   	endfunction : end_of_elaboration_phase


	
endclass : pds_base_test
