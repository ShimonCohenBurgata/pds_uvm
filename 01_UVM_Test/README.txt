This test bench is the start of UVM testing.
It is based on the book The UVM Primer by Ray Salemy.

In this test bench the focus is on
1.	running multiple test with one command + simulator args
2.	create 2 tests with 1 change between them.



UVM usage:
1.	module top:
		import uvm_pkg::*;   Import all uvm resources
2.	module top:
		`include “uvm_macros.svh” import all uvm macros
3.	module top:
		uvm_config_db #(virtual pds_bfm)::set(null, “*”,”bfm”,bfm); store bfm globally so every class can used it.
		#(virtual pds_bfm) is the configuration type we want to store. The first 2 arguments null, “*” makes the data available across the entire test bench.
		The 3rd  argument “bfm” is the name of the data, the 4th argument is the data, an interface in this case.
4.	Module random_test, cpwr_test:
		uvm_config_db #(virtual pds_bfm)::get(null, "*", "bfm", bfm). Static method that gets the bfm that we store in module top.
5.	Module top:
		Run_test() + UVM_TESTNAME=random_test in command line instantiates the random test object. 
6.	Class random_test:
		Random_test extends uvm_test. Now the class inherit all uvm_test base class methods and class members.
7.	Class random test:
		`uvm_component_utils(random_test) register the class in the uvm factory.
8.	Class random test:
		function new (string name, uvm_component parent)… required by
			the uvm in order to construct the class. 
9.	Class random test:
		run_phase(uvm_phase phase) used by uvm the run the test
		defined in the run_phase task.
10.	Class random test:
		phase.raise_objection(this) Uvm understands that this object started to run the test.
11.	Class random test: phase.drop_objection(this); uvm understands that this object finished to run the test.
12.	Class cpwr_tester:
		Extends random tester and change only 1 method   get_pwr_bdg(). This enable the reuse of all the methods in random_tester.










