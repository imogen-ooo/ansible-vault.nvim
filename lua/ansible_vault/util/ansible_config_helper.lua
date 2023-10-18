local util = require('ansible_vault.util.util')
---@class AnsibleConfigHelper
local M = {}


---@return string
M.get_cfg_path = function()
  local cfg_path = ''
  local home_folder_path = vim.fn.expand('$HOME')
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  local env_ansible_config = os.getenv('ANSIBLE_CONFIG')
  if env_ansible_config ~= nil then
    if util.file_exists(env_ansible_config) then
      cfg_path = env_ansible_config
    end
  elseif util.file_exists(string.format("%sansible.cfg", home_folder_path)) then
    cfg_path = string.format("%sansible.cfg", home_folder_path)
  elseif util.file_exists(string.format("%sansible.cfg", cwd)) then
    cfg_path = string.format("%sansible.cfg", cwd)
  end
  return cfg_path
end

---@param cfg_path string the path to the ansible.cfg
---@return table
M.get_vault_ids = function(cfg_path)
  local cfg = io.open(cfg_path, "r")
  local vault_id_table = {}
  if cfg == nil then
    print('cfg invalid, please check cfg_path')
  else
    for line in cfg:lines() do
      if line:match("vault_identity_list") then
        if not line:match('#') then
          local vault_identity_list = util.split(line, '=')
          vault_id_table = util.split(vault_identity_list[2], ',')
        end
      end
    end
  end
  io.close(cfg)
  return vault_id_table
end

M.number_of_vault_ids = function(vault_ids)
  return #vault_ids
end

return M
