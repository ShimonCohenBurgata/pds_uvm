class cpwr_sequence_item extends random_sequence;
	`uvm_object_utils(cpwr_sequence_item)

	constraint const_power {prs.pwr_bdj==8'hFF;}
endclass : cpwr_sequence_item
