/* Shimon Cohen */


module top;
 
   import uvm_pkg::*;
   `include "uvm_macros.svh"
   import pds_pkg::*;

   pds_bfm class_bfm();

   pds pds_dut(class_bfm);

   pds_bfm module_bfm();

   pds module_dut(module_bfm);

   pds_tester_module stim_module(module_bfm);

   initial begin
      uvm_config_db #(virtual pds_bfm)::set(null, "*", "class_bfm", class_bfm);
      uvm_config_db #(virtual pds_bfm)::set(null, "*", "module_bfm", module_bfm);
      run_test("dual_test");
   end


endmodule : top
