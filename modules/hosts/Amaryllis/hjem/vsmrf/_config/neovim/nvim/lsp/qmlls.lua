return {
	cmd = { "qmlls" },
	filetypes = { "qml" },
	root_markers = { ".git", ".qmlls.ini" },
	on_attach = function(client)
		client.server_capabilities.semanticTokenProvider = nil
	end,
}
