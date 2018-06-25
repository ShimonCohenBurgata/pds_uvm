class env_config;
	
	virtual pds_bfm class_bfm;
	virtual pds_bfm module_bfm;

	function new(virtual pds_bfm class_bfm, virtual pds_bfm module_bfm);
		this.class_bfm=class_bfm;
		this.module_bfm=module_bfm;
	endfunction : new
endclass : env_config
