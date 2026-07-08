class reference_model;
  transaction wr_mon_tran;
  
  mailbox #(transaction) rm2sb;
  mailbox #(transaction) mon2rm;
  
  bit [3:0] exp_count;
  
  function new (mailbox #(transaction) rm2sb, mailbox #(transaction) mon2rm);
    this.rm2sb = rm2sb;
    this.mon2rm = mon2rm;
  endfunction
  
  virtual task ref_count(transaction ref_tran);
    if(ref_tran.reset)
      exp_count <= 4'd0;
    else if (ref_tran.load)
      exp_count <= ref_tran.data_in;
    else begin
      if(ref_tran.up_down) begin
        if(exp_count == 4'd11)
          exp_count <= 4'd0;
        else
          exp_count <= exp_count + 4'd1;
      end
      else begin
        if(exp_count == 4'd0)
          exp_count <= 4'd11;
        else
          exp_count <= exp_count - 4'd1;
      end
    end
  endtask
      
  virtual task start;
    fork
      forever begin
        mon2rm.get(wr_mon_tran);
        ref_count(wr_mon_tran);
        wr_mon_tran.count = exp_count;
        rm2sb.put(wr_mon_tran);
      end
    join_none
  endtask
endclass
