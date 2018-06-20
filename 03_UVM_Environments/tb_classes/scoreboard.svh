`include "definitions.txt"
class scoreboard extends uvm_component;
	`uvm_component_utils(scoreboard)

	parameter int numPorts=`numPorts;

	bit [(numPorts-1):0] on_expected[$];
	bit [(numPorts-1):0] on_actual[$];

	virtual pds_bfm bfm;

	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(virtual pds_bfm)::get(null, "*", "bfm", bfm))
			$fatal(1,"Failed to get BFM");
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		repeat(2) @(negedge bfm.clk);
		forever begin:self_checking
			@(negedge bfm.clk)
			on_actual.push_back(bfm.on);
			on_expected.push_back(calc_expected(bfm));
			if(on_expected.size()>=2) begin
				bit [(numPorts-1):0] exp;
				bit [(numPorts-1):0] act;
				exp=on_expected.pop_front;
				act=on_actual.pop_back;
				if(exp != act)
					$error("@%t expected=%d, actual=%d",
						$time, exp, act);
			end
		end:self_checking

	endtask : run_phase


	function bit [(numPorts-1):0] calc_expected(virtual pds_bfm bfm);
	

	// Packed array tp hold priority per port
	logic [(numPorts-1):0][1:0] iprio;

	// Unpacked array to hold priority per port
	logic [1:0] iprioa [(numPorts-1):0],
		
		// Unpacked array to old sorted priority
		iprioa_sorted[(numPorts-1):0],
			
		//list of unique priorities 
		prio_unique[$];
		
	// hold the index for each priority
	int prio_index[$];

		
	int sorted_index[$];
			
	// Hold the port to turn on
	logic [(numPorts-1):0] turn_on;

	// hold the availble power
	integer power_avail;

	// holds the number of ports we can turn on with regurds to
	// avail power
	integer num_ports;

	// sample priority
	iprio=bfm.prio;

	// Set avail power to maximum
	power_avail = bfm.pwr_bdj;

	// calcultates the remining power
	foreach(bfm.on[i])
		power_avail -= 15*bfm.on[i];
		
	//Calculates the number of ports taht can be turned on;
	num_ports = (power_avail - power_avail%15)/15;
	
	// Pcked to unpacked
	foreach(iprio[i]) begin
		iprioa_sorted[i]=iprio[i];
		iprioa[i]=iprio[i];
	end

	//Sort priorities
	iprioa_sorted.sort();

	// Find uniqueness
	prio_unique=iprioa_sorted.unique();

	// Loop over all unique priorites
	foreach(prio_unique[i])begin
			
		// Find the index according to priority
		prio_index=iprioa.find_index with(item==prio_unique[i]);

		//Reverse the list
		prio_index.reverse();
		
		// Loop over all indexes
		foreach(prio_index[j]) begin
			sorted_index.push_front(prio_index[j]);
		end
	end

	// Calculate which port to turn on;
	for(int i=0; i<numPorts; i++) begin
			
		// Check for user ports_off
		if(bfm.ports_off)
			turn_on[sorted_index[i]]=0;
		
		// Check for off request
		else if(bfm.off[sorted_index[i]])
			turn_on[sorted_index[i]]=0;

		// Check if the port is already onn
		else if(bfm.on[sorted_index[i]])
			turn_on[sorted_index[i]]=1;
			
		//turn on the remining port according to priority
		else if(num_ports>0 && bfm.det[sorted_index[i]])begin
			turn_on[sorted_index[i]] = 1;
			num_ports--;
		end
			
		// leave the port off if no det request or no more
		// power
		else
			turn_on[sorted_index[i]] = 0;
	end
	calc_expected=turn_on;
endfunction : calc_expected

endclass : scoreboard
