`include disciplines.vams

module reference(in,out)
  input in;
  output out;
  
  eletrical in,out; //Definition of eletrical components 
  branch (in,out) res; //Definition of a branch, also used explicitly in assignments
  
  voltage a,b; //Definition of nets
  voltage [3:0]vec_net; //Definition of a vector of nets 
  
  
  parameter real gain=1.0 from (0:inf); 
  parameter real R=50.0 exclude 0;
  parameter integer factor1=1 exclude (1:10) exclude (100:1000);
  
  analog begin //Block analog block
    V(out) <+ R1*I(res);
    V(out) <+ R2*I(res); 
    //V(out) <+ (R1 + R2)* I(res); //This line is equivalent to the two lines above
    
    V(out) : V(inp,inn) == 0; //drive V(out) such that V(inp)-V(vinn) is equal to 0
    
    I(a,b) <+ k1 * ($limexp((V(a,b)-k2*I(a,b))/$vt)-1); //Implicit equation where the assigned eletrical is also a variable
  end 
  
  
  analog V(n1,n2)<+1; //In-line analog block
  
  
  analog begin
    $strobe();
    $display;
    $write; //monitor functions
  end
  
  
  //Operators
  + - * / //arithmetic
  % //modulus
  > >= < <= //relational
  ! //negation
  && //logical and
  || //logical or
  == //equality
  != //inequality
  
  ~ //bit-wise negation
  & //bit-wise and
  | //bit-wise or
  ^ //bit-wise exclusive or
  ^~ ~^ //bit-wise equivalence
  << >> // left and right shift
  ? : // in line conditional
  or //event or
  
  
  repeat(10)
    begin
      $strobe("this is written 10 times");
    end
  
  
  //Generate code are flattened after compilation into multiple pieces of code
  /*
  generate i (N, 0) begin
    // piece of code
  end
  */

  
  //loops
  while(condition)
    begin
    end
    
  for(k=1;k<=width;k=k+1)
    begin
    end
  
  forever
    begin
    end
  
  //function
  analog function {real|integer} my_function;
    input n1,n2;
    electrical, n1,n2;
    begin
      my_function = V(V(n1) > V(n2)):V(n1):V(n2);
    end
  endfunction

  //pre-defined funtions
  $realtime
  $temperature
  $vt
  $vt(temp)

  //analog operators: only to be used inside an analog block
  result = delay(expression, time_delay); //transport delay
  result = absdelay(expression, time_delay); //delay for a continuous waveform
  result = transition(expression, delay, rise_time, fall_time);
  result = slew(expression, max_pos_SR, max_neg_SR);
  
  //events: used using @, inside analog process to trigger a piece of code
  @(initial_step("ac","dc","tran"));
  @(final_step("noise"));
  @(cross(expression, direction0 +1 -1, timer_tol, expr_tol));
  @(timer(start_time, period, time_tol));
      
  @(above(expression, time_tol, expr_tol)); //expression is compared to 0 (>=)
  //OR-events
  @(initial_step or cross(V(clk),+1));
    
  //function
  result = last_crossing(expression, direction)); //the time when a signal last crossed 0 in some direction, return negative is never crosses 0
 
  $discontinuity(constant_expression); // tells the simulator that there is a discontinuity: 0 for equation, 1 for slope, -1 for $limit()
  
  //Pre processor directives
  'include "filename"
  'define PI 3.14
  'define SUM(A,B) A+B
  
  'ifdef macro_name
    //statements
  'endif
  
  'ifdef macro_name
    //statements
  'else
    //statements
  'endif
    
    
endmodule
