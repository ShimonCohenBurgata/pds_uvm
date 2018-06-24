Test bench focus:
1. uvm_analysis port
	in previuos chapter we implement the bfm read in the scorebord and in
	the coverage. new we consolidate all signal-level monitoring in the
	bfm. the results is being send to monitors and from there to score
	board and coverage


UVM usage
1. scoreboard
	class scoreboard extends uvm_subscriber #(bit[(`numPorts-1):0]);
	 scoreboard is now a component that get data via the write() method.
	 
	


			
