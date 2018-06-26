class pds_sequence extends uvm_sequence #(pds_sequence_item);
	pds_sequence_item prs;

	task body();
		`uvm_fatal("PDS_SEQUENCE","OVERRIDE PDS SEQUENCE");
	endtask:body
endclass : pds_sequence
