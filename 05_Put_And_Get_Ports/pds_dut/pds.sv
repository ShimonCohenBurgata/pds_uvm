/**********************************************************************
 * PDS top-level module
 * Author: Shimon Cohen 
 *********************************************************************/
`include "definitions.txt"
module pds (pds_bfm bfm);

parameter int numPorts=`numPorts;

// variable to hold how much power is availible
logic [7:0] pwr_avail;

// variable to hold how many ports we can turn on
logic [(numPorts-1):0] num_ports;

// variable the hold the ports to turn on
logic [(numPorts-1):0] turn_on;

// variable to hold the sorted priority
logic [0:(numPorts-1)][($clog2(numPorts)-1):0] prio_sort;

// varable to hold the priority per port
logic [(numPorts-1):0][1:0] prio_pack;

// assign priority into packed array
assign prio_pack = bfm.prio;

// Sort the prio bus
always_comb begin
	prio_sort = sort(bfm.prio);
end

// Calculate how much power is availble
always_comb begin
	// Start calculation with full power
	pwr_avail = bfm.pwr_bdj;

	// Loop over all ports
	for(int i=0; i<numPorts ; i++) begin

		// Substruct a default amount of power if the port is on
		//  Save from negetive 2's complement
		if(pwr_avail >= 4'd15) begin
			pwr_avail = pwr_avail - bfm.on[i]*4'd15;
		end
	end
end

// divide by 4 into oreder to find how many ports we can turn on
//assign num_ports = pwr_avail >> 4;

always_comb begin
	if(pwr_avail<15)
		num_ports=0;
	else if(pwr_avail>=15 && pwr_avail<30)
		num_ports=1;
	else if(pwr_avail>=30 && pwr_avail<45)
		num_ports=2;
	else if(pwr_avail>=45 && pwr_avail<60)
		num_ports=3;
	else if(pwr_avail>=60 && pwr_avail<75)
		num_ports=4;
	else if(pwr_avail>=75 && pwr_avail<90)
		num_ports=5;
	else if(pwr_avail>=90 && pwr_avail<105)
		num_ports=6;
	else if(pwr_avail>=105 && pwr_avail<120)
		num_ports=7;
	else if(pwr_avail>=120 && pwr_avail<135)
		num_ports=8;
	else if(pwr_avail>=135 && pwr_avail<150)
		num_ports=9;
	else if(pwr_avail>=150 && pwr_avail<165)
		num_ports=10;
	else if(pwr_avail>=165 && pwr_avail<180)
		num_ports=11;
	else if(pwr_avail>=180 && pwr_avail<195)
		num_ports=12;
	else if(pwr_avail>=195 && pwr_avail<210)
		num_ports=13;
	else if(pwr_avail>=210 && pwr_avail<225)
		num_ports=14;
	else if(pwr_avail>=225 && pwr_avail<240)
		num_ports=15;
	else if(pwr_avail>=240 && pwr_avail<=255)
		num_ports=15;
	
		
	
end

// Flag that stops to iterate once turn_on[j] is set to 1 (break)
logic flag;

// Decide which port to turn on according to
// priority, det, on off requests
always_comb begin
	// Start the calculation with turn_on equal the the ports that are on
	turn_on = bfm.on & ~bfm.off;

	// Calculate which additional ports to turn on according to avail
	// number of ports
	for(int i=0; i<num_ports; i++) begin
		
		// Set the flag to 1 to enable iteration
		flag = 1'b1;

		// Iterate over all sorted index
		for(int j=0 ; j<numPorts; j++) begin
			if(bfm.det[prio_sort[j]] && ~turn_on[prio_sort[j]] && ~bfm.off[prio_sort[j]] && flag) begin
				// turn on the port
				turn_on[prio_sort[j]]=1'b1;
				// set the flag to stop iterate
				flag=1'b0;
			end
		end
	end
end

// Sample turnOn to on
always_ff @(posedge bfm.clk or negedge bfm.rst_n) begin
	if(~bfm.rst_n)
		bfm.on = 0;
	else if(bfm.ports_off)
		bfm.on = 0;
	else
		bfm.on = turn_on;
end

// Sort the index according to prio function
function automatic logic [0:(numPorts-1)][($clog2(numPorts)-1):0] sort
	(input logic [(numPorts*2-1):0] prio);
	
	logic [0:(numPorts-1)][1:0] temp;

	logic [0:(numPorts-1)][($clog2(numPorts)-1):0] temp_idx;

	logic[1:0] swap;

	logic[($clog2(numPorts)-1):0] swap_idx;

	integer cnt=0;

	for(int i=0; i<numPorts; i++)
		temp[i]={prio[2*i+1],prio[2*i]};


	//$display("temp[0]=%0b, temp[1]=%0b, temp[2]=%0b, temp[3]=%0b",temp[0], temp[1], temp[2], temp[3]);

	for(int i=0; i<numPorts; i++) begin
		temp_idx[i]=cnt;
		cnt++;
	end

	for(int i=0; i<numPorts; i++) begin
		for(int j=1; j<(numPorts-i); j++)begin
			if(temp[j-1]<temp[j]) begin
				swap=temp[j-1];
				temp[j-1]=temp[j];
				temp[j]=swap;

				swap_idx=temp_idx[j-1];
				temp_idx[j-1]=temp_idx[j];
				temp_idx[j] = swap_idx;
			end
		end
	end

	for(int i=0; i<numPorts; i++)
		sort[i]=temp_idx[i];
endfunction
endmodule:pds
