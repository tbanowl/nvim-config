require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})


local convert_lsp_formatters = function(origin_array, extends)
    local copy_array = {}
    for _, value in ipairs(origin_array) do
        copy_array[value] = true
    end
    if extends == nil or type(extends) ~= 'table' then
        return copy_array
    end
    for _, value in ipairs(extends) do
        copy_array[value] = true
    end
    return copy_array
end

local lsp_list = { 'bashls', 'pylsp', 'lua_ls', 'rust_analyzer', 'jdtls' }
local lsp_formtters = convert_lsp_formatters(lsp_list, { 'null-ls' })

require('mason-lspconfig').setup({
    -- A list of servers to automatically install if they're not already installed
    -- This setting has no relation with the `automatic_installation` setting.
    ---@type string[]
    ensure_installed = lsp_list,

    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    ---@type boolean
    automatic_installation = false
})

-- Set different settings for different languages' LSP.
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP.
--     - on_attach: a lua callback function to run after LSP attaches to a given buffer.
local lspconfig = require 'lspconfig'

-- Customized on_attach function.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions.
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer.
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

    if client.name == "rust_analyzer" then
        -- WARNING: This feature requires Neovim v0.10+
        vim.lsp.inlay_hint.enable()
    end

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({
            async = true,
            -- Predicate used to filter clients. Receives a client as
            -- argument and must return a boolean. Clients matching the
            -- predicate are included.
            filter = function(lsp_client)
                -- NOTE: If an LSP contains a formatter, we don't need to use null-ls at all.
                -- return client.name == "null-ls" or client.name == "hls" or client.name == "rust_analyzer" or client.name == "jdtls"
                -- local tmp = ''
                -- for key, value in pairs(lsp_formtters) do
                --     tmp = tmp..key..'='..tostring(value)..','
                -- end
                -- print(lsp_client.name, tmp, lsp_formtters[lsp_client.name])
                return lsp_formtters[lsp_client.name]
            end
        })
    end
    )
end

-- How to add an LSP for a specific programming language?
-- 1. Use `:Mason` to install the corresponding LSP.
-- 2. Add the configuration below. The syntax is `lspconfig.<name>.setup(...)`
-- Hint (find <name> here) : https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
lspconfig.pylsp.setup({
    on_attach = on_attach,
})

lspconfig.gopls.setup({
    on_attach = on_attach,
})

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim).
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global.
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files.
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier.
            telemetry = {
                enable = false,
            },
        },
    },
})

lspconfig.bashls.setup({})

lspconfig.rust_analyzer.setup({
    -- source: https://rust-analyzer.github.io/manual.html#nvim-lsp
    on_attach = on_attach,
})

lspconfig.clangd.setup({
    on_attach = on_attach,
})

lspconfig.ocamllsp.setup({
    on_attach = on_attach,
})

lspconfig.ruby_lsp.setup({
    on_attach = on_attach,
})

-- Case 1. For CMake Users
--     $ cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
-- Case 2. For Bazel Users, use https://github.com/hedronvision/bazel-compile-commands-extractor
-- Case 3. If you don't use any build tool and all files in a project use the same build flags
--     Place your compiler flags in the compile_flags.txt file, located in the root directory
--     of your project. Each line in the file should contain a single compiler flag.
-- src: https://clangd.llvm.org/installation#compile_commandsjson
lspconfig.clangd.setup({
    on_attach = on_attach,
})

lspconfig.hls.setup({
    on_attach = on_attach,
})


local java_config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        --增加lombok插件支持，getter setter good bye
        "-javaagent:/Users/neptune/.lombok/share/nvim/jdtls/lombok.jar",
        "-Xbootclasspath/a:/Users/neptune/.lombok/share/nvim/jdtls/lombok.jar",
        '-jar',
        '/Users/neptune/.local/share/nvim/jdtls/plugins/org.eclipse.equinox.launcher_1.6.1000.v20250131-0606.jar',
        "-configuration",
        '/Users/neptune/.local/share/nvim/jdtls/config_mac',
        '-data',
        '/Users/neptune/.local/share/nvim/jdtls/workspace/folder'
    },
    root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
    settings = {
        java = {}
    },
    init_options = {
        bundles = {}
    },
    on_attach = on_attach,
}
-- require("jdtls").start_or_attach(java_config)

-- 在语言服务器附加到当前缓冲区之后
-- 使用 on_attach 函数仅映射以下键
local java_on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- local function buf_set_option(...)
    --   vim.api.nvim_buf_set_option(bufnr, ...)
    -- end

    --Enable completion triggered by <c-x><c-o>
    -- buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
    -- Mappings.
    local opts = { noremap = true, silent = true }
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    --buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    --重命名
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    --智能提醒，比如：自动导包 已经用lspsaga里的功能替换了
    buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    --buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap("n", "<S-C-j>", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    --代码格式化
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    buf_set_keymap("n", "<leader>l", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    buf_set_keymap("n", "<leader>l", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    --自动导入全部缺失的包，自动删除多余的未用到的包
    buf_set_keymap("n", "<A-o>", "<cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    --引入局部变量的函数 function to introduce a local variable
    buf_set_keymap("n", "crv", "<cmd>lua require('jdtls').extract_variable()<CR>", opts)
    buf_set_keymap("v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    --function to extract a constant
    buf_set_keymap("n", "crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
    buf_set_keymap("v", "crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
    --将一段代码提取成一个额外的函数function to extract a block of code into a method
    buf_set_keymap("v", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

    -- 代码保存自动格式化formatting
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
end

lspconfig.jdtls.setup({
    on_attach = on_attach,
})
