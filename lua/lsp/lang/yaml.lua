return {
	settings = {
		yaml = {
			schemaStore = { enable = false, url = "" },
			schemas = require("schemastore").yaml.schemas(),
			validate = true,
			format = { enable = true },
		},
		redhat = { telemetry = { enabled = false } },
	},
}
