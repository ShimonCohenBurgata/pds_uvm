`include "definitions.txt"
class scoreboard extends uvm_subscriber #(bit[(`numPorts-1):0]);
	`uvm_component_utils(scoreboard)

	parameter int numPorts=`numPorts;

	bit [(numPorts-1):0] on_expected[$];
	bit [(numPorts-1):0] on_actual[$];

	uvm_tlm_analysis_fifo #(prs_transaction) prs_f;


	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		prs_f=new("prs_f",this);
	endfunction : build_phase

	function void write(bit [(numPorts-1):0] t);
		prs_transaction prs;
		bit ok=prs_f.try_get(prs);
		bit [(numPorts-1):0] expected;
		bit [(numPorts-1):0] actual;
		string data_str;
		if(!ok)
			`uvm_fatal("SCOREBOARD","Could not get prs struct from fifo get");
		on_actual.push_back(t);
		on_expected.push_back(calc_expected(prs));
		if(on_expected.size()>=2) begin
			expected=on_expected.pop_front;
			actual=on_actual.pop_back;
			data_str = $sformatf("@%0t scoreboard on_actal=%h, on_expected=%h",$time,actual,expected);
			if(expected != actual)
				`uvm_error("SCOREBOARD",{"FAIL: ",data_str})
			else
				`uvm_info("SCOREBOARD",{"PASS: ",data_str},UVM_HIGH)

		end
	endfunction :write
	

	function bit [(numPorts-1):0] calc_expected(prs_transaction prs);
	

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
	iprio=prs.prio;

	// Set avail power to maximum
	power_avail = prs.pwr_bdj;

	// calcultates the remining power
	foreach(prs.on[i])
		power_avail -= 15*prs.on[i];
		
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
		if(prs.ports_off)
			turn_on[sorted_index[i]]=0;
		
		// Check for off request
		else if(prs.off[sorted_index[i]])
			turn_on[sorted_index[i]]=0;

		// Check if the port is already onn
		else if(prs.on[sorted_index[i]])
			turn_on[sorted_index[i]]=1;
			
		//turn on the remining port according to priority
		else if(num_ports>0 && prs.det[sorted_index[i]])begin
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
