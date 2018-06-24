/* random tester */
`include "definitions.txt"

virtual class base_tester extends uvm_component;
	`uvm_component_utils(base_tester)
   
   parameter int numPorts=`numPorts;

   uvm_put_port #(prs_s) prs_port;

   function new(string name, uvm_component parent);
	   super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
		  prs_port=new("prs_port",this);
   endfunction : build_phase



   pure virtual function bit [(numPorts-1):0] get_det();
   
   pure virtual function bit [(numPorts-1):0] get_off();

   pure virtual function bit [(2*numPorts-1):0] get_prio();

   pure virtual function bit [7:0] get_pwr_bdj();

   pure virtual function bit [(numPorts-1):0] get_ports_off();

   task run_phase(uvm_phase phase);

	prs_s prs;
   	bit [(numPorts-1):0] idet;
   	bit [(numPorts-1):0] ioff;
   	bit [(2*numPorts-1):0] iprio;
   	bit [7:0] ipwr_bdj;
   	bit iports_off;

	phase.raise_objection(this);

	repeat (200) begin : pwr_bdj_loop
		prs.pwr_bdj=get_pwr_bdj();
		repeat(200) begin : random_loop
		prs.det=get_det();
		prs.off=get_off();
		prs.prio=get_prio();
		prs.ports_off=get_ports_off();
		prs_port.put(prs);
		end : random_loop
	end : pwr_bdj_loop

	phase.drop_objection(this);
   endtask : run_phase



endclass : base_tester
