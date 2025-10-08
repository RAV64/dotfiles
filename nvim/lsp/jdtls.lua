--- [official downloads site](http://download.eclipse.org/jdtls/snapshots/?d)

local java11 = "/opt/homebrew/opt/openjdk@11"
local java17 = "/opt/homebrew/opt/openjdk@17"
local java21 = "/opt/homebrew/opt/openjdk@21"

local runtimes = {
	{ name = "JavaSE-11", path = java11, default = true },
	{ name = "JavaSE-17", path = java17 },
	{ name = "JavaSE-21", path = java21 },
}

local function get_jdtls_cache_dir()
	return vim.fn.stdpath("cache") .. "/jdtls"
end

local function get_jdtls_workspace_dir()
	return get_jdtls_cache_dir() .. "/workspace"
end

local function get_jdtls_jvm_args()
	local env = os.getenv("JDTLS_JVM_ARGS")
	local args = {}
	for a in string.gmatch((env or ""), "%S+") do
		local arg = string.format("--jvm-arg=%s", a)
		table.insert(args, arg)
	end
	return unpack(args)
end

local root_markers = {
	".git",
	"build.gradle",
	"build.xml", -- Ant
	"pom.xml", -- Maven
	"settings.gradle", -- Gradle
}

return {
	cmd = function(dispatchers, config)
		local data_dir = get_jdtls_workspace_dir()

		if config.root_dir then
			data_dir = data_dir .. "/" .. vim.fn.fnamemodify(config.root_dir, ":p:h:t")
		end

		local config_cmd = {
			"jdtls",
			"-data",
			data_dir,
			get_jdtls_jvm_args(),
		}

		return vim.lsp.rpc.start(config_cmd, dispatchers, {
			cwd = config.cmd_cwd,
			env = config.cmd_env,
			detached = config.detached,
		})
	end,
	cmd_env = {
		JAVA_HOME = java21,
		PATH = java21 .. "/bin:" .. os.getenv("PATH"),
	},
	settings = {
		java = {
			-- eclipse = { downloadSources = true },
			-- maven = { downloadSources = true },
			configuration = {
				runtimes = runtimes,
				updateBuildConfiguration = "automatic",
			},
			compile = {
				nullAnalysis = {
					mode = "automatic",
					nonnullbydefault = {},

					nullable = {
						"org.jetbrains.annotations.Nullable",
					},
					nonnull = {
						"org.jetbrains.annotations.NotNull",
					},
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
		},
	},
	filetypes = { "java" },
	root_markers = root_markers,
	init_options = {},
}
