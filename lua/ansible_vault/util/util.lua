---@class Util
local M = {}

M.split = function (inputstr, sep)
   if sep == nil then
      sep = "%s"
   end
   local t={}
   for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(t, str)
   end
   return t
end

M.file_exists = function (name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end


return M
