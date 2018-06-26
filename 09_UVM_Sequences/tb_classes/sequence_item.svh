`include "definitions.txt"
class sequence_item extends uvm_sequence_item;
	`uvm_object_utils(sequence_item)
	parameter int numPorts=`numPorts;

	rand bit [(numPorts-1):0] det;
   	rand bit [(numPorts-1):0] off;
   	rand bit [(2*numPorts-1):0] prio;
   	rand bit [7:0] pwr_bdj;
   	rand bit ports_off;
	rand bit [(numPorts-1):0] result;

	constraint data{ports_off dist {1'b1:=1, 1'b0:=20};}

	function new (string name="");
		super.new(name);
	endfunction : new

	function void do_copy(uvm_object rhs);
		sequence_item RHS;
		if(rhs==null)
			`uvm_fatal("PRS_TRANSACTION","Tried to copy from null pointer");

		if(!$cast(RHS,rhs))
			`uvm_fatal("PRS_TRANSACTION","Tried to copy wrong type");

		super.do_copy(rhs);

		det=RHS.det;
		off=RHS.off;
		prio=RHS.prio;
		pwr_bdj=RHS.pwr_bdj;
		ports_off=RHS.ports_off;

	endfunction : do_copy

	function bit do_compare(uvm_object rhs, uvm_comparer comparer);
		sequence_item tested;
		bit same;

		if(rhs==null)
			`uvm_fatal("PRS_TRANSACTION","Tried to copy from null pointer");
		
		if(!$cast(tested,rhs))
			same=0;

		else
			same= super.do_compare(rhs,comparer) &&
			(tested.det==det) &&
			(tested.off==off) &&
			(tested.prio==prio)&&
			(tested.pwr_bdj==pwr_bdj)&&
			(tested.ports_off==ports_off);
		return same;
	endfunction : do_compare

	function string convert2string();
		string s;
		s=$sformatf("det=%h, off=%h, prio=%h, pwr_bdj=%h, ports_off=%b",
			det,off,prio,pwr_bdj,ports_off);
		return s;
	endfunction : convert2string

		

endclass : sequence_item
