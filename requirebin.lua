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

-- see more info in README.md :D

local PATH = {} -- binaries pathes

local delim = package.config:sub(1,1) -- path delimiter

-- TODO: check is ':' character is valid for windows?
for p in string.gmatch(os.getenv('PATH'), '([^:]*):?') do
	PATH[#PATH + 1] = p 
end

local function binloader(name, simple)
	local f = function(...)
		local f = io.popen(table.concat({
			name, ...
		}, ' '), 'r')
		local s = f and f:read('a') or nil
		local suc = f and f:close() or false
		return s, suc
	end
	if not _ENV[simple] then
		_ENV[simple] = f
	end
	return f, name
end

package.searchers[#package.searchers + 1] = function (name)
	for _, v in pairs(PATH) do 
		local f = io.open(v..delim..name)
		if f then
			f:close()
			return binloader, v..delim..name, name
		end
	end
	return 'no executable file found!'
end

