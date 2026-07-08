interface interface_mod12 (input bit clk);
  logic reset, load, up_down;
  logic [3:0] data_in;
  logic [3:0] count;
  
  //Write Driver Clocking Block
  clocking wr_drv_cb @(posedge clk);
    default input #1 output #1;
    output load;
    output up_down;
    output data_in;
    output reset;
  endclocking
    
  //Write Monitor Clocking Block
  clocking wr_mon_cb @(posedge clk);
    default input #1 output #1;
    input load;
    input up_down;
    input data_in;
  endclocking
  
  //Read Monitor Clocking Block
  clocking rd_mon_cb @(posedge clk);
    default input #1 output #1;
    input count;
  endclocking
  
  //Modport for Every Clocking Block
  modport WR_DRV_MP (clocking wr_drv_cb);
    modport WR_MON_MP (clocking wr_mon_cb);
      modport RD_MON_MP (clocking rd_mon_cb);

        endinterface
        
        
