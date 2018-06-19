class cpwr_tester extends random_tester;

	function new (virtual pds_bfm b);
		super.new(b);
	endfunction : new

	protected virtual function bit [7:0] get_pwr_bdj();
	   return 8'hFF;
        endfunction : get_pwr_bdj
endclass : cpwr_tester
