class cpwr_test extends pds_base_test;
	`uvm_component_utils(cpwr_test)

	function new (string name, uvm_component parent);
      		super.new(name,parent);
   	endfunction : new

	task run_phase(uvm_phase phase);
      		cpwr_sequence cpwr;
      		cpwr = new("cpwr");

      		phase.raise_objection(this);
      		cpwr.start(sequencer_h);
      		phase.drop_objection(this);
   endtask : run_phase
	
endclass : cpwr_test
