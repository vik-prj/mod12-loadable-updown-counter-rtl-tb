class write_driver;
  virtual interface_mod12.WR_DRV_MP wr_drv_if;
  
  transaction data2duv;
  mailbox #(transaction) gen2drv;
  
  function new (mailbox #(transaction) gen2drv, virtual interface_mod12.WR_DRV_MP wr_drv_if);
    this.gen2drv = gen2drv;
    this.wr_drv_if = wr_drv_if;
  endfunction
  
  virtual task drive();
    begin
      @(wr_drv_if.wr_drv_cb);
      wr_drv_if.wr_drv_cb.load <= data2duv.load;
      wr_drv_if.wr_drv_cb.data_in <= data2duv.data_in;
      wr_drv_if.wr_drv_cb.up_down <= data2duv.up_down;
    end
  endtask
  
  virtual task start();
    fork
      forever begin
        gen2drv.get(data2duv);
        drive();
      end
    join_none
  endtask
endclass
