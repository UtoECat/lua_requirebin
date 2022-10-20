# lua_requirebin
A tiny lua library that allows you to include binary executables as functions, written in pure lua.

# usage
```lua
require "lua_requirebin"
pstree = require "pstree"
print(pstree())
```   
The result function returns a string containing the output of the called application to standard output, and status.   
You can even pass arguments to process : 
```lua
ls = require "ls"
print(ls('-l', '-d'))
```
# use cases
1. To replace shell scripts with lua scripts (lua can be compiled)
