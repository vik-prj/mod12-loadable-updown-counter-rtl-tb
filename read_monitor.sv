class read_monitor;
  virtual interface_mod12.RD_MON_MP rd_mon_if;
  
  transaction duv2mon, data2sb;
  
  mailbox #(transaction) mon2sb;
  
  function new (mailbox #(transaction) mon2sb, virtual interface_mod12.RD_MON_MP rd_mon_if);
    this.mon2sb = mon2sb;
    this.rd_mon_if = rd_mon_if;
    this.duv2mon = new();
  endfunction
  
  virtual task monitor();
    @(rd_mon_if.rd_mon_cb)
    begin
      duv2mon.count = rd_mon_if.rd_mon_cb.count;
    end
  endtask
  
  virtual task start();
    fork
      forever begin
        monitor();
        data2sb = new duv2mon; //Shallow Copy
        mon2sb.put(data2sb);
      end
    join_none
  endtask
endclass
