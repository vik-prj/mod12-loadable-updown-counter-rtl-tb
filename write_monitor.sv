class write_monitor;
  virtual interface_mod12.WR_MON_MP wr_mon_if;
  
  mailbox #(transaction) mon2rm;
  
  transaction duv2mon, data2rm;
  
  function new (mailbox #(transaction) mon2rm, virtual interface_mod12.WR_MON_MP wr_mon_if);
    this.mon2rm = mon2rm;
    this.wr_mon_if = wr_mon_if;
    duv2mon = new();
  endfunction
  
  virtual task monitor();
    @(wr_mon_if.wr_mon_cb);
    begin
      duv2mon.load = wr_mon_if.wr_mon_cb.load;
      duv2mon.up_down = wr_mon_if.wr_mon_cb.up_down;
      duv2mon.data_in = wr_mon_if.wr_mon_cb.data_in;
    end
  endtask
  
  virtual task start();
    fork
        forever begin
          monitor();
          data2rm = new duv2mon; //Shallow Copy
          mon2rm.put(data2rm);
        end
    join_none
  endtask
endclass
          
    
