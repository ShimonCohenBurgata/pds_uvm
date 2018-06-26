/* random test */

class random_test extends pds_base_test;
	 `uvm_component_utils(random_test)


   	function new(string name, uvm_component parent);
      		super.new(name, parent);
   	endfunction : new

	task run_phase(uvm_phase phase);
		random_sequence random_h;	
		random_h=new("random_h");
		phase.raise_objection(this);
		random_h.start(sequencer_h);
		phase.drop_objection(this);
	endtask : run_phase

endclass : random_test
