3740-group
==========

###### Repo for 3740 Scheme project

#### Group Members:
  Matt Forster  - matt.forster@uleth.ca
  Justin Werre  - justin.werre@uleth.ca
  Josh Enns     - ennsj@uleth.ca
  
# Program Organization:
  
  __Strings are not supported.__

__Globals__ _First Code Section_
------------------------------------

  All global variables are declared at the top of the code.
  The globals consist of all the static storage the program needs from the input buffer to the stack itself.


__Helpers__ _Second Code Section_
------------------------------------

  * `cb`
    - Convert Boolean, takes a boolean type and pushes either 0 or 1
  * `top`
    - Returns the top of the stack
  * `lastof`
    - Returns the last element of the list passed
  * `removelast`
    - Returns a list with the last element removed
  * `moveto`
    - Returns a list of elements that existed _after_ the sentenial given
  * `upto`
    - Returns a list of elements that existed _befores_ the sentenial given

__Operations__ _Third Code Section_
------------------------------------

  * `oper` 
    - primary function that analyses the token and calls the appropriate operation function.
  * `push`
    - Pushes an item to the top of the stack
  * `pop`
    - Pops an item off the stack and saves it to the temporary storage
  * `drop`
    - Drops an item off the stack
  * `save`
    - Saves an item from the temporary storage to the top of the stack
  * `dup`
    - Duplicates the top item of the stack
  * `swap`
    - Swaps the first two elements of the stack
  * `printall`
    - Prints the stack
  * `clear`
    - Clears the stack
  * `printone`
    - Prints the top item of the stack
  * `plus`
    - Add the two top items of the stack and pushes the result
  * `minus`
    - Minus the two top items of the stack and pushes the result
  * `mult`
    - Multiplies the two top items of the stack and pushes the result
  * `div`
    - Divides the two top items of the stack and pushes the result
  * `less`
    - Compares the two top items of the stack with less than, pushes the result
  * `more`
    - Compares the two top items of the stack with greater than, pushes the result
  * `lesseq`
      - Compares the two top items of the stack with less than or equal, pushes the result 
  * `moreeq`
      - Compares the two top items of the stack with greater than or equal, pushes the result

__If Logic__ _Fourth Code Section_
------------------------------------

  * `ifcond`
    - Takes two token lists, executes one or the other depending on the state of the stack,

__Loop Logic__ _Fifth Code Section_
------------------------------------

  * `loopcomp`
    - Takes the comparison, condition, and loop tokens and executes the tokens an amount of times depending on the state of the stack.

__Function Logic__ _Sixth Code Section_
----------------------------------------

  * `printfuncs`
    - Prints the names of the functions
  * `addfunc`
    - Adds a function to the list. The list takes the form of ( ((name) (tokens)), ... )
  * `findfunc`
    - Finds a function in the list and executes it

__Token Logic__ _Seventh Code Section_
---------------------------------------

  * `tokenizer`
    - Takes a complete string of tokens and turns it into a list of tokens
  * `tokenhandler`
    - Takes a list of tokens and executes each one separately

__Input Logic__ _Eight_ 
------------------------------------

  * `main`
    - Starts the input prompt
  * `read-line`
    - Reads a line of input as individual characters

# Testing

All tests are located in "tests" file.
When the file is run it will display each test name and will show the output of the test alond with the expected output.
For example, the push test pushes 7 onto the stack and then displays the following message:
7 expected: 7
This confirms that the value on the stack is the same as the expected value.

This is the style of testing for the entire program and each primary function has at least one test confirming its correctness.
