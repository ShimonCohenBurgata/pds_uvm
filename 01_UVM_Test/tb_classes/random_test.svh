/* random test */

class random_test extends uvm_test;
   `uvm_component_utils(random_test)

   virtual pds_bfm bfm;

   function new(string name, uvm_component parent);
      super.new(name, parent);
      if(!uvm_config_db #(virtual pds_bfm)::get(null, "*", "bfm", bfm))
	      $fatal(1,"Failed to get BFM");
   endfunction : new

   task run_phase(uvm_phase phase);
      random_tester random_tester_h;
      coverage coverage_h;
      scoreboard scoreboard_h;
      phase.raise_objection(this);

      random_tester_h=new(bfm);
      coverage_h=new(bfm);
      scoreboard_h=new(bfm);

      fork
	 coverage_h.execute();
	 scoreboard_h.execute();
      join_none

      random_tester_h.execute();
      phase.drop_objection(this);
   endtask : run_phase
	

endclass : random_test
