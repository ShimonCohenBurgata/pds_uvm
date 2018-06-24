class prs_monitor extends uvm_component;
	`uvm_component_utils(prs_monitor)

	
	uvm_analysis_port #(prs_s) ap;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);

		virtual pds_bfm bfm;

		if(!uvm_config_db #(virtual pds_bfm)::get(null, "*", "bfm", bfm))
			$fatal(1, "Faild to get bfm");
		
		bfm.prs_monitor_h=this;
		
		ap=new("ap", this);

	endfunction : build_phase

	function void write_to_monitor(	bit [(numPorts-1):0] idet, bit [(numPorts-1):0] ioff,
					bit [(2*numPorts-1):0] iprio, bit [7:0] ipwr_bdj,
					bit iports_off, bit[(numPorts-1):0] ion);
		
		prs_s s;
		s.det=idet;
		s.off=ioff;
		s.prio=iprio;
		s.pwr_bdj=ipwr_bdj;
		s.ports_off=iports_off;
		s.on=ion;
		/*$display("@%0t det=%h, off=%h, prio=%h, pwr_bdj=%h, ports_off=%h, on=%h",
			$time, s.det, s.off, s.prio, s.pwr_bdj, s.ports_off, s.on);*/
		ap.write(s);
	endfunction : write_to_monitor




endclass : prs_monitor
