/* random tester */
`include "definitions.txt"

class tester extends uvm_component;
	`uvm_component_utils(tester)
   
   parameter int numPorts=`numPorts;

   uvm_put_port #(prs_transaction) prs_port;

   function new(string name, uvm_component parent);
	   super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
		  prs_port=new("prs_port",this);
   endfunction : build_phase



   task run_phase(uvm_phase phase);

	bit [(`numPorts-1):0] temp;

	bit ok;

	prs_transaction prs;

	phase.raise_objection(this);

	prs=new("prs");



	repeat (20) begin : pwr_bdj_loop
		prs=prs_transaction::type_id::create("prs");
		ok=prs.randomize();
		if(!ok)
			`uvm_fatal("TESTER","Failed to randomize pwr_bdj");

		prs.ports_off=1'b1;
		prs_port.put(prs);
		temp=prs.pwr_bdj;
		
		repeat(20) begin : random_loop
		prs=prs_transaction::type_id::create("prs");
		ok=prs.randomize();
		if(!ok)
			`uvm_fatal("TESTER","Failed to randomize tester");
		prs.pwr_bdj=temp;
		prs_port.put(prs);
		end : random_loop
	end : pwr_bdj_loop

	phase.drop_objection(this);
   endtask : run_phase



endclass : tester
