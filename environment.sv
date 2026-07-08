class environment;
  generator gen_h;
  write_driver wr_drv_h;
  write_monitor wr_mon_h;
  read_monitor rd_mon_h;
  reference_model rm_h;
  scoreboard sb_h;
  
  mailbox #(transaction) gen2drv = new();
  mailbox #(transaction) mon2rm = new();
  mailbox #(transaction) mon2sb = new();
  mailbox #(transaction) rm2sb = new();
  
  virtual interface_mod12.WR_DRV_MP wr_drv_if;
  virtual interface_mod12.WR_MON_MP wr_mon_if;
  virtual interface_mod12.RD_MON_MP rd_mon_if;
  
  function new (virtual interface_mod12.WR_DRV_MP wr_drv_if, virtual interface_mod12.WR_MON_MP wr_mon_if, virtual interface_mod12.RD_MON_MP rd_mon_if);
    this.wr_drv_if = wr_drv_if;
    this.wr_mon_if = wr_mon_if;
    this.rd_mon_if = rd_mon_if;
  endfunction
  
  virtual task build();
    gen_h = new(gen2drv);
    wr_drv_h = new(gen2drv,wr_drv_if);
    wr_mon_h = new(mon2rm,wr_mon_if);
    rd_mon_h = new(mon2sb,rd_mon_if);
    rm_h = new(rm2sb,mon2rm);
    sb_h = new(rm2sb,mon2sb);
  endtask
  
  virtual task start();
    gen_h.start;
    wr_drv_h.start;
    wr_mon_h.start;
    rd_mon_h.start;
    rm_h.start;
    sb_h.start;
  endtask
  
  virtual task reset_duv();
    @(wr_drv_if.wr_drv_cb);
    wr_drv_if.wr_drv_cb.reset <= 1'b1;
    repeat(2) @(wr_drv_if.wr_drv_cb);
    wr_drv_if.wr_drv_cb.reset <= 1'b0;
  endtask
  
  virtual task run();
    reset_duv();
    start();
    sb_h.report();
  endtask
endclass
