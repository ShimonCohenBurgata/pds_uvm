`include "definitions.txt"
class result_transaction extends uvm_transaction;
	`uvm_object_utils(result_transaction)

	parameter int numPorts = `numPorts;

	bit [(numPorts-1):0] result;

	function new (string name="");
		super.new(name);
	endfunction : new

	function void do_copy(uvm_object rhs);
		result_transaction copied_transaction_h;
		assert(rhs!=null) else `uvm_fatal("RESULT_TRANS","Tried to copy null transaction");
		result = copied_transaction_h.result;
	endfunction : do_copy

	function string convert2string();
		string s;
		s=$sformatf("result:%h", result);
		return s;
	endfunction : convert2string

	function bit do_compare(uvm_object rhs, uvm_comparer comparer);
		result_transaction RHS;
		bit same;
		assert(rhs!=null) else `uvm_fatal("RESULT_MONITOR","Tried to compare null transaction");
		same=super.do_compare(rhs, comparer);
		$cast(RHS, rhs);
		same=(result==RHS.result) && same;
		return same;
	endfunction : do_compare

endclass : result_transaction
