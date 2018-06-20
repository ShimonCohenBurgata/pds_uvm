/* random tester */
`include "definitions.txt"

class random_tester extends base_tester;
	`uvm_component_utils(random_tester)
   
   parameter int numPorts=`numPorts;


   function new(string name, uvm_component parent);
	   super.new(name, parent);
   endfunction : new


   function bit [(numPorts-1):0] get_det();
      bit [1:0] zero_ones;
      zero_ones=$random;
      if(zero_ones==2'b00)
         return 8'h00;
      else if (zero_ones==2'b11)
	 return 8'hFF;
      else
	 return $random;
   endfunction : get_det
   
   function bit [(numPorts-1):0] get_off();
      bit [1:0] zero_ones;
      zero_ones=$random;
      if(zero_ones==2'b00)
         return 8'h00;
      else if (zero_ones==2'b11)
	 return 8'hFF;
      else
	 return $random;
   endfunction : get_off

   function bit [(2*numPorts-1):0] get_prio();
	 return $random;
   endfunction : get_prio

   function bit [7:0] get_pwr_bdj();
	 return $random;
   endfunction : get_pwr_bdj

   function bit [(numPorts-1):0] get_ports_off();
   	bit [7:0] zero_ones;
        zero_ones=$random;
	if(zero_ones==8'd56)
           return 1'b1;
	else
	   return 1'b0;
   endfunction : get_ports_off

endclass : random_tester
