/* environment class*/

class env extends uvm_env;
	`uvm_component_utils(env)

	pds_agent class_pds_agent_h;
	pds_agent_config class_config_h;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		virtual pds_bfm class_bfm;
		env_config env_config_h;

		if(!uvm_config_db #(env_config)::get(this,"","config",env_config_h))
			`uvm_fatal("ENV","Failed to get ENV_CONFIG");
		
		class_config_h=new(.bfm(env_config_h.class_bfm), .is_active(UVM_ACTIVE));

		uvm_config_db #(pds_agent_config)::set(this,"class_pds_agent_h*",
							"config",class_config_h);

		class_pds_agent_h=new("class_pds_agent_h",this);

	endfunction : build_phase

endclass : env
