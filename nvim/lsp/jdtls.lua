--- [official downloads site](http://download.eclipse.org/jdtls/snapshots/?d)

local java11 = "/opt/homebrew/opt/openjdk@11"
local java17 = "/opt/homebrew/opt/openjdk@17"
local java21 = "/opt/homebrew/opt/openjdk@21"

local runtimes = {
	{ name = "JavaSE-11", path = java11, default = true },
	{ name = "JavaSE-17", path = java17 },
	{ name = "JavaSE-21", path = java21 },
}

local env = {
	HOME = vim.uv.os_homedir(),
	XDG_CACHE_HOME = os.getenv("XDG_CACHE_HOME"),
	JDTLS_JVM_ARGS = os.getenv("JDTLS_JVM_ARGS"),
}

local function get_cache_dir()
	return env.XDG_CACHE_HOME and env.XDG_CACHE_HOME or env.HOME .. "/.cache"
end

local function get_jdtls_cache_dir()
	return get_cache_dir() .. "/jdtls"
end

local function get_jdtls_jvm_args()
	local args = {}
	for a in string.gmatch((env.JDTLS_JVM_ARGS or ""), "%S+") do
		local arg = string.format("--jvm-arg=%s", a)
		table.insert(args, arg)
	end
	return unpack(args)
end

local root_markers = {
	-- Multi-module projects
	".git",
	"build.gradle",
	"build.gradle.kts",
	-- Single-module projects
	"build.xml", -- Ant
	"pom.xml", -- Maven
	"settings.gradle", -- Gradle
	"settings.gradle.kts",
}

local function find_root()
	local path = vim.fs.find(root_markers, { upward = true })[1]
	return path and vim.fs.dirname(path) or vim.uv.cwd()
end

-- Per-project workspace: <cache>/jdtls/workspace/<repo-name>-<short-hash>
local function project_workspace_dir(root_dir)
	local base = vim.fn.fnamemodify(root_dir, ":t")
	local abs = vim.fn.fnamemodify(root_dir, ":p")
	local hash = vim.fn.sha256(abs):sub(1, 8)
	return table.concat({ get_jdtls_cache_dir() .. "/workspace", base .. "-" .. hash }, "/")
end

local function ensure_dir(p)
	vim.fn.mkdir(p, "p")
	return p
end

local workspace_dir = ensure_dir(project_workspace_dir(find_root()))

return {
  -- stylua: ignore
	cmd = {
		"jdtls",
		"-configuration", get_jdtls_cache_dir() .. "/config",
		"-data", workspace_dir,
		get_jdtls_jvm_args(),
	},
	cmd_env = {
		JAVA_HOME = java21,
		PATH = java21 .. "/bin:" .. os.getenv("PATH"),
	},
	settings = {
		java = {
			-- eclipse = { downloadSources = true },
			-- maven = { downloadSources = true },
			configuration = { runtimes = runtimes },
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
		},
	},
	filetypes = { "java" },
	root_markers = root_markers,
	init_options = {
		workspace = workspace_dir,
		jvm_args = {},
		os_config = nil,
	},
}
