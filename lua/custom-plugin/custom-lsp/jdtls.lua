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
