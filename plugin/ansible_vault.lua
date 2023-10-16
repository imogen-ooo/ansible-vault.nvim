-- Title:        ansible-vault.nvim
-- Description:  ansible-vault encrypting and decrypting within nvim
-- Last Change:  3 October 2023
-- Maintainer:   imogen-ooo <https://github.com/imogen-ooo>

local api = vim.api

-- Prevents the plugin from being loaded multiple times. If the loaded
-- variable exists, do nothing more. Otherwise, assign the loaded
-- variable and continue running this instance of the plugin.

if vim.g.loaded_ansible_vault == 1 then
  return
end
vim.g.loaded_ansible_vault = 1


api.nvim_create_user_command(
  "AnsibleVaultDecrypt",
  {desc = 'decrypt ansible vault'}
)
