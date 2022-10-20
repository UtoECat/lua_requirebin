--[[
 * Allows to require executable binaries like lua functions.
 *
 * Copyright (C) UtoECat 2022. All rights reserved!
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>. --
--]]

-- After require this file, you will able just write :
-- > bin = require 'binary'
-- And then call it :
-- > print(bin('argument 1', 'argument 2'))
-- And it will prints text output of this program + status boolean
--
-- returned after require function does the same, what popen does :)

local PATH = {} -- binaries pathes

local delim = package.config:sub(1,1) -- path delimiter

-- TODO: check is ':' character is valid for windows?
for p in string.gmatch(os.getenv('PATH'), '([^:]*):?') do
	PATH[#PATH + 1] = p 
end

local function elfloader(name)
	return function(...)
		local f = io.popen(table.concat({
			name, ...
		}, ' '), 'r')
		local s = f:read('a')
		local suc = f and f:close() or false
		return s, suc
	end, name
end

package.searchers[#package.searchers + 1] = function (name)
	for _, v in pairs(PATH) do 
		local f = io.open(v..delim..name)
		if f then
			f:close()
			return elfloader, v..delim..name
		end
	end
	return 'no executable file found!'
end

