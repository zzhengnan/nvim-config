vim.api.nvim_create_user_command("OpenRemote", function()
	local ssh_url = table.concat(vim.fn.systemlist("git remote get-url origin"), "\n")
	local branch_name = table.concat(vim.fn.systemlist("git branch --show-current"), "\n")
	local file_name = vim.fn.expand("%:."):gsub("\\", "/") -- :. to get relative path to current directory
	local line_number = vim.fn.line(".")
	local base_url = string.gsub(ssh_url, "git@(.+):(.+).git$", "https://%1/%2") -- Only works for SSH
	local full_url = base_url .. "/blob/" .. branch_name .. "/" .. file_name .. "#L" .. line_number
	local escaped_url = vim.fn.shellescape(full_url) -- Protects spaces, quotes, etc.

	local cmd
	if vim.fn.has("macunix") == 1 then
		cmd = "open"
	elseif vim.fn.has("win32") == 1 then
		-- cmd “start” requires an empty title string before the URL
		cmd = 'cmd /c start ""'
	else
		cmd = "xdg-open"
	end
	cmd = cmd .. " " .. escaped_url

	vim.fn.jobstart(cmd)
	vim.notify("Opened " .. escaped_url .. " in browser")
end, {})

vim.api.nvim_create_user_command("CopyPath", function()
	local path = vim.fn.expand("%:."):gsub("\\", "/")
	vim.fn.setreg("+", path)
	vim.notify("Copied '" .. path .. "' to system clipboard")
end, {})
