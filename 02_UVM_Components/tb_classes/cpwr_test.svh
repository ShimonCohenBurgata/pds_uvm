/* constant power test */

class cpwr_test extends uvm_test;
   `uvm_component_utils(cpwr_test)
	
   cpwr_tester tester_h;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

endclass : cpwr_test

