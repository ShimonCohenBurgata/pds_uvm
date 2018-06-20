/* random tester */
`include "definitions.txt"

class random_tester extends uvm_test;
	`uvm_component_utils(random_tester)
   
   parameter int numPorts=`numPorts;

   virtual pds_bfm bfm;

   function new(string name, uvm_component parent);
	   super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
	   if(!uvm_config_db #(virtual pds_bfm)::get(null, "*", "bfm", bfm))
		   $fatal(1, "Failed to get BFM");
   endfunction : build_phase



   protected virtual function bit [(numPorts-1):0] get_det();
      bit [1:0] zero_ones;
      zero_ones=$random;
      if(zero_ones==2'b00)
         return 8'h00;
      else if (zero_ones==2'b11)
	 return 8'hFF;
      else
	 return $random;
   endfunction : get_det
   
   protected virtual function bit [(numPorts-1):0] get_off();
      bit [1:0] zero_ones;
      zero_ones=$random;
      if(zero_ones==2'b00)
         return 8'h00;
      else if (zero_ones==2'b11)
	 return 8'hFF;
      else
	 return $random;
   endfunction : get_off

   protected virtual function bit [(2*numPorts-1):0] get_prio();
	 return $random;
   endfunction : get_prio

   protected virtual function bit [7:0] get_pwr_bdj();
	 return $random;
   endfunction : get_pwr_bdj

   protected virtual function bit [(numPorts-1):0] get_ports_off();
   	bit [7:0] zero_ones;
        zero_ones=$random;
	if(zero_ones==8'd56)
           return 1'b1;
	else
	   return 1'b0;
   endfunction : get_ports_off

   task run_phase(uvm_phase phase);
   	bit [(numPorts-1):0] idet;
   	bit [(numPorts-1):0] ioff;
   	bit [(2*numPorts-1):0] iprio;
   	bit [7:0] ipwr_bdj;
   	bit iports_off;

	phase.raise_objection(this);

	bfm.reset_pds();

	repeat (200) begin : pwr_bdj_loop
		ipwr_bdj=get_pwr_bdj();
		repeat(200) begin : random_loop
		idet=get_det();
		ioff=get_off();
		iprio=get_prio();
		iports_off=get_ports_off();
		bfm.send_op(idet, ioff, iprio, ipwr_bdj, iports_off);
		end : random_loop
	end : pwr_bdj_loop

	phase.drop_objection(this);
   endtask : run_phase



endclass : random_tester
