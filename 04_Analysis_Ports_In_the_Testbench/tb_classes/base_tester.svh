/* random tester */
`include "definitions.txt"

virtual class base_tester extends uvm_component;
	`uvm_component_utils(base_tester)
   
   parameter int numPorts=`numPorts;

   virtual pds_bfm bfm;

   function new(string name, uvm_component parent);
	   super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
	   if(!uvm_config_db #(virtual pds_bfm)::get(null, "*", "bfm", bfm))
		   $fatal(1, "Failed to get BFM");
   endfunction : build_phase



   pure virtual function bit [(numPorts-1):0] get_det();
   
   pure virtual function bit [(numPorts-1):0] get_off();

   pure virtual function bit [(2*numPorts-1):0] get_prio();

   pure virtual function bit [7:0] get_pwr_bdj();

   pure virtual function bit [(numPorts-1):0] get_ports_off();

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



endclass : base_tester
