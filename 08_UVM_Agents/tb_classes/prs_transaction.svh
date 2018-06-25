`include "definitions.txt"
class prs_transaction extends uvm_transaction;
	`uvm_object_utils(prs_transaction)
	parameter int numPorts=`numPorts;

	rand bit [(numPorts-1):0] det;
   	rand bit [(numPorts-1):0] off;
   	rand bit [(2*numPorts-1):0] prio;
   	rand bit [7:0] pwr_bdj;
   	rand bit ports_off;
	rand bit [(numPorts-1):0] on;

	constraint data{ports_off dist {1'b1:=1, 1'b0:=20};}

	function new (string name="");
		super.new(name);
	endfunction : new

	function void do_copy(uvm_object rhs);
		prs_transaction copied_transaction_h;
		if(rhs==null)
			`uvm_fatal("PRS_TRANSACTION","Tried to copy from null pointer");

		if(!$cast(copied_transaction_h,rhs))
			`uvm_fatal("PRS_TRANSACTION","Tried to copy wrong type");

		super.do_copy(rhs);

		det=copied_transaction_h.det;
		off=copied_transaction_h.off;
		prio=copied_transaction_h.prio;
		pwr_bdj=copied_transaction_h.pwr_bdj;
		ports_off=copied_transaction_h.ports_off;

	endfunction : do_copy

	function prs_transaction clone_me();
		prs_transaction clone;
		uvm_object tmp;

		tmp=this.clone();
		$cast(clone,tmp);
		return clone;
	endfunction : clone_me

	function bit do_compare(uvm_object rhs, uvm_comparer comparer);
		prs_transaction compared_transaction_h;
		bit same;

		if(rhs==null)
			`uvm_fatal("PRS_TRANSACTION","Tried to copy from null pointer");
		
		if(!$cast(compared_transaction_h,rhs))
			same=0;

		else
			same= super.do_compare(rhs,comparer) &&
			(compared_transaction_h.det==det) &&
			(compared_transaction_h.off==off) &&
			(compared_transaction_h.prio==prio)&&
			(compared_transaction_h.pwr_bdj==pwr_bdj)&&
			(compared_transaction_h.ports_off==ports_off);
		return same;
	endfunction : do_compare

	function string convert2string();
		string s;
		s=$sformatf("det=%h, off=%h, prio=%h, pwr_bdj=%h, ports_off=%b",
			det,off,prio,pwr_bdj,ports_off);
		return s;
	endfunction : convert2string

		

endclass : prs_transaction
