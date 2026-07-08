module mod_12_loadable_counter (clk, reset, load, up_down, data_in, count);
  input clk, reset, load, up_down;
  input [3:0] data_in;
  output reg [3:0] count;
  
  always @(posedge clk) begin
    if(reset) begin
      count <= 4'b0;
    end
    else if (load) begin
      if(data_in < 4'b1100)
        count <= data_in;
      else
        count <= 4'b0;
    end
    else
      begin
        if(up_down) begin
          if(count == 4'b1011)
            count <= 4'b0;
          else
            count <= count + 4'b1;
        end
        else begin
          if(count == 4'b0)
            count <= 4'b1011;
          else
            count <= count - 4'b1;
        end
      end
  end
endmodule
      
      
