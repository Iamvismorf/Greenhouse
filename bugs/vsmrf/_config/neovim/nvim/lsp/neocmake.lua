return {
	single_file_support = true,
	cmd = { "neocmakelsp", "--stdio" },
	filetypes = { "cmake" },
	root_markers = { ".git", "build", "cmake" },
	init_options = {
		format = {
			enable = true,
		},
		lint = {
			enable = false,
		},
		scan_cmake_in_package = true,
	},
}
