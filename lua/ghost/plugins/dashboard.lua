local setup, dashboard = pcall(require, "dashboard")
if not setup then
	return
end

dashboard.setup({})
