/* environment class*/

class env extends uvm_env;
	`uvm_component_utils(env)

	base_tester tester_h;
	driver driver_h;
	uvm_tlm_fifo #(prs_s) prs_f;

	coverage coverage_h;
	scoreboard scoreboard_h;
	prs_monitor prs_monitor_h;
	result_monitor result_monitor_h;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		prs_f=new("prs_f", this);
		tester_h=base_tester::type_id::create("tester_h", this);
		driver_h=driver::type_id::create("driver_h", this);
		coverage_h=coverage::type_id::create("coverage_h", this);
		scoreboard_h=scoreboard::type_id::create("scoreboard_h", this);
		result_monitor_h=result_monitor::type_id::create("result_monitor_h", this);
		prs_monitor_h=prs_monitor::type_id::create("prs_monitor_h", this);
	endfunction : build_phase

	function void connect_phase(uvm_phase phase);
		driver_h.prs_port.connect(prs_f.get_export);
		tester_h.prs_port.connect(prs_f.put_export);

		prs_monitor_h.ap.connect(coverage_h.analysis_export);
		prs_monitor_h.ap.connect(scoreboard_h.prs_f.analysis_export);
		result_monitor_h.ap.connect(scoreboard_h.analysis_export);
	endfunction : connect_phase

endclass : env
