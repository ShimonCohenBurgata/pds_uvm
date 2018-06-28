class cpwr_sequence_item extends sequence_item;
	`uvm_object_utils(cpwr_sequence_item)

	function new(string name="");
		super.new(name);
	endfunction : new

	constraint cpwr {pwr_bdj==8'hFF;}
endclass : cpwr_sequence_item
