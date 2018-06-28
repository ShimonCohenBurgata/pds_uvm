class cpwr_sequence extends random_sequence;
	`uvm_object_utils(cpwr_sequence)

	cpwr_sequence_item prs;
	function new(string name="");
		super.new(name);
	endfunction : new

	task body();

		repeat (20) begin : cpwr_loop
			bit ok;
			prs=cpwr_sequence_item::type_id::create("prs");
			start_item(prs);
			ok=prs.randomize();
			if(!ok)
				`uvm_fatal("CPWR_SEQUENCE","Failed to randomize prs");
			finish_item(prs);
		end : cpwr_loop
	endtask : body

endclass : cpwr_sequence
