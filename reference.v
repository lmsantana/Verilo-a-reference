`include disciplines.vams

module reference(in,out)
  input in;
  output out;
  
  eletrical in,out;
  
  parameter real gain=1.0 from (0:inf); 
  parameter real res=50.0 exclude 0;
  parameter integer factor1=1 exclude (1:10) exclude (100:1000);
  
  analog begin
    
  end 
  
  
  
endmodule
