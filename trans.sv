class transaction;
  rand bit load;
  rand bit up_down;
  rand bit [3:0] data_in;
  
  bit reset;
  logic [3:0] count;
  
  //we can add Constraints here !!
  
  virtual function void display(input string s);
    begin
      $display("%s",s);
      $display("Reset = %d", reset);
      $display("Up_Down = %d", up_down);
      $display("Load = %d \t Data In = %d", load, data_in);
      $display("Count = %d", count);
    end
  endfunction
endclass
  
