-- Imports dependencies
local utils = {
  table = require 'utils.table',
  module_loader = require 'utils.module-loader',
}

-- stdpath
local base_plugins_dir = vim.fn.stdpath 'config'

-- 1/4: Read all files directly under the `buildin` folder.
utils.module_loader.load_all(base_plugins_dir .. '/lua/buildin', 'buildin.')

-- 2/4:
-- - Read all files directly under the `plugins` folder.
-- - At this time, keymap and settings for plug-ins are also loaded.
local plugin_features = {}
for _, file in ipairs(vim.fn.readdir(base_plugins_dir .. '/lua/plugins', [[v:val =~ '\.lua$']])) do
  plugin_features[#plugin_features + 1] = file:gsub('%.lua$', '')
end
local plugins = utils.table.concat_fields(plugin_features, 'plugins', 'common_plugins')

-- 3/4: External plugins are loaded by the Plugin Manager.
require('plugins-manager').load(plugins)

-- 4/4: Load plugins settings.
utils.module_loader.load_all(base_plugins_dir .. '/lua/plugins-settings', 'plugins-settings.')

-- Edit vimrc
vim.keymap.set('n', '<leader>v', function()
  -- local sfile = debug.getinfo(1, 'S').short_src
  local sfile = base_plugins_dir .. '/init.lua'
  -- I'm clenching errors in pcall to prevent buff errors in `editerconfig.nvim`.
  pcall(vim.cmd.edit, sfile)
end, { desc = '[v]iew & edit init.lua' })

-- vim.keymap.set('n', '<leader>r', function()
--   --See: https://github.com/folke/lazy.nvim/issues/445#issuecomment-1426070401
--   for _, plugin in ipairs(require('lazy.core.config').plugins) do
--     require('lazy.core.loader').reload(plugin)
--   end
-- end, { desc = '[r]eload init.lua' })
