local config = {
    -- 启动语言服务器的命令
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        -- 💀
        'java', -- 或者绝对路径 '/path/to/java11_or_newer/bin/java'
        -- 取决于 `java` 是否在您的 $PATH 环境变量中以及它是否指向正确的版本。

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        -- 💀
        --'-jar', '/path/to/jdtls_install_location/plugins/org.eclipse.equinox.launcher_VERSION_NUMBER.jar',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
        -- 必须指向                                                               修改这里为
        -- eclipse.jdt.ls 安装路径                                                实际版本
        '-jar', '/Users/neptune/.local/share/nvim/jdtls/plugins/org.eclipse.equinox.launcher_1.6.1000.v20250131-0606.jar',

        -- 💀
        --'-configuration', '/path/to/jdtls_install_location/config_SYSTEM',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
        -- Must point to the                      Change to one of `linux`, `win` or `mac`
        -- eclipse.jdt.ls installation            Depending on your system.
        --这里是我们上面解压的jdt-language-server绝对路径，我这里是linux，请根据系统类型调整
        '-configuration', '/home/vnc/.local/share/nvim/lsp/jdt-language-server/config_linux',
        '-configuration', '/Users/neptune/.local/share/nvim/jdtls/config_mac',

        -- 💀
        -- 请参阅 README 中的“数据目录配置”部分
        '-data', '/Users/neptune/.local/share/nvim/jdtls/workspace/folder'
    },

    -- 💀
    -- 这是默认设置，如果未提供，您可以将其删除。 或根据需要进行调整。
    -- 每个唯一的 root_dir 将启动一个专用的 LSP 服务器和客户端
    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

    -- 这里可以配置eclipse.jdt.ls具体设置
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- 选项列表
    settings = {
        java = {
        }
    },

    -- Language server `initializationOptions`
    -- 您需要使用 jar 文件的路径扩展 `bundles`
    -- 如果你想使用额外的 eclipse.jdt.ls 插件。
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- 如果您不打算使用调试器或其他 eclipse.jdt.ls 插件，您可以删除它
    init_options = {
        bundles = {}
    },
}

NVIM_JDTLS_CONFIG = config
