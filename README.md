# lua_requirebin
A tiny lua library that allows you to include binary executables as functions, written in pure lua.

# usage
```lua
require "requirebin"
pstree = require "pstree"
print(pstree())
```   
The result function returns a string containing the output of the called application to standard output, and status.   
You can even pass arguments to process : 
```lua
ls = require "ls"
print(ls('-l', '-d'))
```    
***NEW FEATURE :***    
assigning the result of require to a global variable is now optional! If the variable by the name of the executable file is empty, a function will also be written to it.
# use cases
1. To replace shell scripts with lua scripts (lua can be compiled)

# todo
1. Check is it works on windows.     
~~2. Adding a function to global variables if it is empty.~~
