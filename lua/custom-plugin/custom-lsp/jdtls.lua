function jdtls_callback()
  local set = vim.opt_local
  set.shiftwidth = 4

  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local workspace_dir = os.getenv 'HOME' .. '/.cache/jdtls/workspace/' .. project_name

  -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
  local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
      vim.fn.expand '$HOME/.local/share/nvim/mason/bin/jdtls',
      ('--jvm-arg=-javaagent:%s'):format(vim.fn.expand '$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar'),
      '--jvm-arg=-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '--jvm-arg=-Dosgi.bundles.defaultStartLevel=4',
      '--jvm-arg=-Declipse.product=org.eclipse.jdt.ls.core.product',
      '--jvm-arg=-Dlog.protocol=true',
      '--jvm-arg=-Dlog.level=ALL',
      '--jvm-arg=-Xmx1g',
      '--jvm-arg=--add-modules=ALL-SYSTEM',
      '--jvm-arg=--add-opens',
      '--jvm-arg=java.base/java.util=ALL-UNNAMED',
      '--jvm-arg=--add-opens',
      '--jvm-arg=java.base/java.lang=ALL-UNNAMED',
      '-data',
      workspace_dir,
    },

    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    --
    -- vim.fs.root requires Neovim 0.10.
    -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
    root_dir = vim.fs.root(0, { '.git', 'mvnw', 'gradlew' }),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
      java = {},
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
      bundles = {},
    },
  }

  -- add auto command for adding package name
  -- vim.api.nvim_create_autocmd('BufNew', {
  --   desc = 'add skeleton when filetype is java',
  --   pattern = { '*.java' },
  --   group = vim.api.nvim_create_augroup('add-java-skeleton-new-file', { clear = true }),
  --   callback = function() end,
  -- })

  local state = {}
  vim.api.nvim_create_autocmd('LspNotify', {
    callback = function(args)
      local bufnr = args.buf
      local client_id = args.data.client_id
      local method = args.data.method
      local params = args.data.params

      -- do something with the notification
      if method == 'workspace/didChangeWatchedFiles' then
        for _, change in ipairs(params.changes) do
          local path = change.uri:gsub('^file://', '')
          if change.type == 1 and state[path] == nil and path:match '(.*)%.java' ~= nil then
            state[path] = 1
            -- TODO: error handling
            vim.uv.fs_open(path, 'w', 420, function(_, fd)
              local package_path, class_name = path:match '^.*java/(.*)/(.*).java'
              package_path = string.gsub(package_path, '%/', '.')
              local data_buf = 'package ' .. package_path .. ';\n\n' .. 'public class ' .. class_name .. ' {\n}'
              -- TODO: error handling
              vim.uv.fs_write(fd, data_buf, function(_)
                vim.uv.fs_close(fd)
              end)
            end)
          end
        end
        -- TODO: something that fires after 5 seconds if the size gets too big
      end
    end,
  })
  -- This starts a new client & server,
  -- or attaches to an existing client & server depending on the `root_dir`.
  require('jdtls').start_or_attach(config)
end

return {
  'mfussenegger/nvim-jdtls',
  dependencies = { { 'mfussenegger/nvim-dap', opt = false } },
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'java',
      callback = jdtls_callback,
    })
  end,
}
