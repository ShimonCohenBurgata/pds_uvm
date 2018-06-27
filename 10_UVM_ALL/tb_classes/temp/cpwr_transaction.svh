class cpwr_transaction extends prs_transaction;
	`uvm_object_utils(cpwr_transaction)
	
	constraint const_pwr {pwr_bdj==8'hFF;}

	function new (string name="");
		super.new(name);
	endfunction : new
endclass : cpwr_transaction
