return {
  "adalessa/laravel.nvim",
  enabled = false,
  dependencies = {
    "tpope/vim-dotenv",
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
    "ravitemer/mcphub.nvim", -- optional
  },
  cmd = { "Laravel" },
  keys = {
    { "<leader>ll", function() Laravel.pickers.laravel() end,              desc = "Laravel: Open Laravel Picker" },
    { "<c-g>",      function() Laravel.commands.run("view:finder") end,    desc = "Laravel: Open View Finder" },
    { "<leader>la", function() Laravel.pickers.artisan() end,              desc = "Laravel: Open Artisan Picker" },
    { "<leader>lt", function() Laravel.commands.run("actions") end,        desc = "Laravel: Open Actions Picker" },
    { "<leader>lr", function() Laravel.pickers.routes() end,               desc = "Laravel: Open Routes Picker" },
    { "<leader>lh", function() Laravel.run("artisan docs") end,            desc = "Laravel: Open Documentation" },
    { "<leader>lm", function() Laravel.pickers.make() end,                 desc = "Laravel: Open Make Picker" },
    { "<leader>lc", function() Laravel.pickers.commands() end,             desc = "Laravel: Open Commands Picker" },
    { "<leader>lo", function() Laravel.pickers.resources() end,            desc = "Laravel: Open Resources Picker" },
    { "<leader>lp", function() Laravel.commands.run("command_center") end, desc = "Laravel: Open Command Center" },
    {
      "gf",
      function()
        local ok, res = pcall(function()
          if Laravel.app("gf").cursorOnResource() then
            return "<cmd>lua Laravel.commands.run('gf')<cr>"
          end
        end)
        if not ok or not res then
          return "gf"
        end
        return res
      end,
      expr = true,
      noremap = true,
    },
  },
  cond = function()
    return vim.fn.filereadable(vim.fn.getcwd() .. "/artisan") == 1
  end,
  event = { "VeryLazy" },
  opts = {
    lsp_server = "intelephense", -- "phpactor | intelephense"
    features = {
      pickers = {
        provider = "telescope", -- "snacks | telescope | fzf-lua | ui-select"
      },
    },
  },
  config = function(_, opts)
    -- Patch api:run to always return an ApiResponse, working around upstream bug
    -- where a plain {} is returned on failure causing :failed() to crash
    local ok, ApiResponse = pcall(require, "laravel.dto.api_response")
    if ok then
      local api_mod = require("laravel.services.api")
      local original_run = api_mod.run
      api_mod.run = function(self, program, args)
        local response, err = original_run(self, program, args)
        if err and not response.failed then
          return ApiResponse:new({}, 1, { tostring(err) }), err
        end
        return response, err
      end
    end
    require("laravel").setup(opts)

    -- Patch views diagnostic: upstream requires the Log class instead of
    -- resolving an instance from the DI container, causing :write() to crash.
    -- local views_ok, views_diag = pcall(require, "laravel.extensions.diagnostic.views")
    -- if views_ok then
    --   local orig_handle = views_diag.handle
    --   views_diag.handle = function(self, bufnr)
    --     local success, err = pcall(orig_handle, self, bufnr)
    --     if not success then
    --       vim.notify("[laravel.nvim] views diagnostic error: " .. tostring(err), vim.log.levels.DEBUG)
    --     end
    --   end
    -- end
  end,
}
