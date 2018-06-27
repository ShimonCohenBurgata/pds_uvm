/* constant power test */

class cpwr_test extends random_test;
   `uvm_component_utils(cpwr_test)

	
   function new(string name, uvm_component parent);
	   super.new(name, parent);
   endfunction : new
  
   
   function void build_phase(uvm_phase phase);
	   prs_transaction::type_id::set_type_override(cpwr_transaction::get_type());
	   super.build_phase(phase);
   endfunction : build_phase

endclass : cpwr_test
