class cpwr_sequence_item extends sequence_item;
	`uvm_object_utils(add_sequence_item)
	constraint cpwr {pwr_bdj==8'hFF}
endclass : cpwr_sequence_item
