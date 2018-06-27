/* Shimon Cohen */


module top;
 
   import uvm_pkg::*;
   `include "uvm_macros.svh"
   import pds_pkg::*;

   pds_bfm class_bfm();

   pds pds_dut(class_bfm);


   initial begin
      uvm_config_db #(virtual pds_bfm)::set(null, "*", "class_bfm", class_bfm);
      run_test();
   end


endmodule : top
