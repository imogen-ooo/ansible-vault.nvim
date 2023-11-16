-- main decrypt file
local decrypt = require("ansible_vault.decrypt")
local ansible_config_helper = require("ansible_vault.util.ansible_config_helper")
local util = require('ansible_vault.util.util')

local home_folder_path = vim.fn.expand('$HOME')
local cwd = vim.fn.getcwd()
local cfg_path = string.format("%s/ansible.cfg", cwd)
---@class Config
---@field opt string Your config option
local config = {
  vault_ids = { "${home_folder_path}/.vault_password", },
  cfg_path = { cfg_path }
}
local vault_id_table = ansible_config_helper.get_vault_ids(cfg_path)

---@class AnsibleVault
local M = {}

---@type Config
M.config = config

M.decrypt_file = function(file)
  for id in vault_id_table do
    local handle = io.popen(string.format('ansible-vault decrypt %s %s', file, id))
    local output = handle:read('*a')
    local format = output:gsub('[\n\r', ' ')
    if format == 'success' then
      return 'success'
    end
  end
end

---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.hello = function()
  decrypt.my_first_function()
end

return M
