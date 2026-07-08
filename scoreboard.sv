class scoreboard;
  
  transaction from_rm;
  transaction from_sb;
  
  mailbox #(transaction) rm2sb;
  mailbox #(transaction) mon2sb;
  
  function new (mailbox #(transaction) rm2sb, mailbox #(transaction) mon2sb);
    this.rm2sb = rm2sb;
    this.mon2sb = mon2sb;
  endfunction
  
  virtual task start();
    fork 
      forever begin
        rm2sb.get(from_rm);
        mon2sb.get(from_sb);
        check(from_sb);
      end
    join_none
  endtask
  
  virtual task check (transaction txn);
    if(from_rm.count == txn.count)
      $display("COUNT MATCHES");
    else
      $display("COUNT NOT MATCHING");
  endtask
  
  virtual task report();
    $display("SCOREBOARD REPORT");
    $display("\t Data Generated : %d", from_rm);
  endtask
endclass  
