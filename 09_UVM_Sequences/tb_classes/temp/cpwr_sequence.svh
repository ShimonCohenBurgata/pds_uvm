class cpwr_sequence extends uvm_sequence #(sequence_item);
	`uvm_object_utils(cpwr_sequence)

	sequence_item prs;

	function new(string name="cpwr");
		super.new(name);
	endfunction : new

	task body();
		repeat (10) begin
			prs=cpwr_sequence_item::type_id::create("prs");
			start_item(prs);
			bit ok=prs.randomize();
			if(!ok)
				`uvm_fatal("CPWR_SEQUENCE","Failed to randomize prs");
			finish_item(prs);
		end
	endtask : body
endclass : cpwr_sequence
