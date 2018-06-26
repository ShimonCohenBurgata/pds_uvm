class random_sequence extends uvm_sequence #(sequence_item);
	`uvm_object_utils(random_sequence)


	function new(string name="random_sequence");
		super.new(name);
	endfunction : new

	task body();
		sequence_item prs;

		repeat (20) begin : random_loop
			bit ok;
			prs=sequence_item::type_id::create("prs");
			start_item(prs);
			ok=prs.randomize();
			if(!ok)
				`uvm_fatal("RANDOM_SEQUENCE","Failed to randomize prs");
			finish_item(prs);
		end : random_loop
	endtask : body
endclass : random_sequence
