3740-group
==========

Repo for 3740 Scheme project

Group Members:
  //not sure if you wanted your uleth or gmail emails here...
  Matt Forster
  Justin Werre
  Josh Enns - ennsj@uleth.ca
  
Program Organization:
All global variables are declared at the top of the code.
The second section consists of helper functions.
  cb
  top
  lastof
  removelast
  moveto
  upto
The third section consists of operation functions.
  oper - primary function that analyses the token and calls the appropriate operation function.
  push
  pop
  drop
  save
  dup
  swap
  printall
  clear
  printone
  plus
  minus
  mult
  div
  less
  more
  lesseq
  moreeq
The fourth section consists of "if" related functions.
  ifcond
The fifth section consists of "loop" related functions.
  loopcomp
The sixth section consists of "function" related functions.
  printfuncs
  addfunc
  findfunc
The seventh section consists of "token" related functions.
  tokenizer
  tokenhandler
The eighth section consists of "input" related functions.
  main
  read-line

Testing:
All tests are located in "tests" file.
When the file is run it will display each test name and will show the output of the test alond with the expected output.
For example, the push test pushes 7 onto the stack and then displays the following message:
7 expected: 7
This confirms that the value on the stack is the same as the expected value.

This is the style of testing for the entire program and each primary function has at least one test confirming its correctness.
