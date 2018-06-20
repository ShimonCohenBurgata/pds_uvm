Test bench focus:
1. create adaptable architecture for the tester calsses
	in tb 02_UVM_Components the main tester wad random_tester. cpwr_test
	inherit from it and override get_pwr_bdj. at part we create
	base_tester with pure virtual gets. the base tester hust deals with
	send the transactions and the classes that extend from base tester can
	change the gets methods behaviour.
2. separating structure from stimulus:
	in 02_UVM_Component tb random_test and cpwr_test add 3 object
	insts random_tester, coverage, scoreboard. if we want to different tb
	structure we will have a problem. for this we have env object.


UVM usage:

1. class env:
	tester_h=base_tester::type_id::create("tester_h", this);
	create object of type base_tester the same go for scoreboard and
	coverage. base_tester is a uvm_component this is why we inherit the
	create method.
2. class random_test:
	base_tester::type_id::set_type_override(random_tester::get_type());
	random_tester::get_type(), random_tester is a uvm component this why
	we inherit the get_type method. because base_type was registerd,
	the factory knews him and can change is type. becuase of polymorphism
	base_tester can point to ranodom_tester. all the casting is being done
	automatically. 


			
