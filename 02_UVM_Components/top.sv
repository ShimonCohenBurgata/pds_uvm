/* Shimon Cohen */


module top;
 
   import uvm_pkg::*;
   `include "uvm_macros.svh"
   import pds_pkg::*;

   pds_bfm bfm();
   pds DUT(bfm);

   initial begin
      uvm_config_db #(virtual pds_bfm)::set(null, "*", "bfm", bfm);
      run_test();
   end


endmodule : top
