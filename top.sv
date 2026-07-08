`include "package.sv"
`include "interface.sv"
module top;
  import pkg::*;
  
  reg clock;
  
  interface_mod12 DUV_IF(clock);
  
  test test_h;
  
  mod_12_loadable_counter DUV (.clk(clock), .reset(DUV_IF.reset), .load(DUV_IF.load), .up_down(DUV_IF.up_down), .data_in(DUV_IF.data_in), .count(DUV_IF.count));
  
  initial begin
    begin
      test_h = new (DUV_IF,DUV_IF,DUV_IF);
      test_h.build();
      test_h.run();
      $finish();
    end
  end
endmodule
      
    
  
