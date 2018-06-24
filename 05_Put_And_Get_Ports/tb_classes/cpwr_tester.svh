class cpwr_tester extends random_tester;
	`uvm_component_utils(cpwr_tester)

	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function bit [7:0] get_pwr_bdj();
	   return 8'hFF;
        endfunction : get_pwr_bdj
endclass : cpwr_tester
