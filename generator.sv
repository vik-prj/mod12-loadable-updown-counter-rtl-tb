class generator;
  transaction trans;
  transaction data2send;
  
  mailbox #(transaction) gen2drv;
  
  function new (mailbox #(transaction) gen2drv);
    this.gen2drv = gen2drv;
    this.trans = new();
  endfunction
  
  virtual task start();
    fork
      begin
        for(int i = 0; i < 1; i++) begin
          assert(trans.randomize()); //Randomization
          data2send = new trans; //Shallow Copy
          gen2drv.put(data2send);
        end
      end
    join_none
  endtask
endclass
