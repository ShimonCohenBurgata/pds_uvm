/* constant power test */

class cpwr_test extends uvm_test;
   `uvm_component_utils(cpwr_test)

   env env_h;
	
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
	   base_tester::type_id::set_type_override(cpwr_tester::get_type());
	   env_h=env::type_id::create("env_h", this);
   endfunction : build_phase

endclass : cpwr_test
