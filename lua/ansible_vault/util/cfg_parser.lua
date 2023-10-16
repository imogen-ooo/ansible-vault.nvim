local util = require ('util.util')
---@class CfgParser
local M = {}

---@param cfg_path string the path to the ansible.cfg
---@return table
M.get_vault_ids = function(cfg_path)
  local cfg = io.open(cfg_path, "r")
  local vault_ids = {}
  for line in cfg:lines() do
    if line:match("vault_identity_list") then
      local vault_identity_list = util.split(line, '=')
      vault_ids = util.split(vault_identity_list[2], ',')
    end
  end
  io.close(cfg)
  return vault_ids
end

M.number_of_vault_ids = function(vault_ids)
  return #vault_ids
end

return M
