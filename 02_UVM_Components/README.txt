Test bench focus: convert 01_UVM_Test classes into extensions of uvm_component
and create a test bench structure.

UVM usage
	
1. class scoreboard:
	class scoreboard extends uvm_components. scoreboard now inherit all
	uvm_test methods
2. class scoreboard:
	`uvm_component_utils(scoreboard) register scoreboard to factory.
3. class scoreboard:
	function new(string name, uvm_component parent).. constructor
4. class scoreboard:
	function void build_phase(uvm_phase phase);... get bfm from factory
	in 01_UVM_Test the scoreboard get his bfm from random_test object.
	this means that if someone want to use thos class elsewhere he
	also as to get the bfm from different object. it is better
	that every object will get its own bfm from the factory.
5. class scoreboard:
	task run_phase(uvm_phase phase); becuase scoreboard is now a uvm
	component it will get his thread by the uvm. phase is not been
	used in this case but it is a must.
6. class random_test:
	no longer has run_phase only build_phase where you build all the
	components. the run_phase is now class method
7. class add_test:
	becuase cpwr_test inherit from random_test he also inherit build_phase. the only thing left is to override tester_h class member
	to cpwr_tester
	
	

	

	


