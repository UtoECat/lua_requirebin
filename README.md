# lua_requirebin
A tiny lua library that allows you to include binary executables as functions, written in pure lua.

# usage
```require "lua_requirebin"
pstree = require "pstree"
print(pstree())```   
The result function returns a string containing the output of the called application to standard output, and status.
