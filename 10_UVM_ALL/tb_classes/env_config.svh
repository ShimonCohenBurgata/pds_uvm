class env_config;
	
	virtual pds_bfm class_bfm;

	function new(virtual pds_bfm class_bfm);
		this.class_bfm=class_bfm;
	endfunction : new
endclass : env_config
