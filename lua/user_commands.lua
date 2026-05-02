local function get_remote_base_url()
	local ssh_url = table.concat(vim.fn.systemlist("git remote get-url origin"), "\n")
	return string.gsub(ssh_url, "git@(.+):(.+).git$", "https://%1/%2") -- Only works for SSH
end

local function open_in_browser(url)
	local escaped_url = vim.fn.shellescape(url) -- Protects spaces, quotes, etc.
	local cmd
	if vim.fn.has("macunix") == 1 then
		cmd = "open"
	elseif vim.fn.has("win32") == 1 then
		-- cmd "start" requires an empty title string before the URL
		cmd = 'cmd /c start ""'
	else
		cmd = "xdg-open"
	end
	vim.fn.jobstart(cmd .. " " .. escaped_url)
	vim.notify("Opened " .. escaped_url .. " in browser")
end

vim.api.nvim_create_user_command("OpenRemote", function()
	local branch_name = table.concat(vim.fn.systemlist("git branch --show-current"), "\n")
	local file_name = vim.fn.expand("%:."):gsub("\\", "/") -- :. to get relative path to current directory
	local line_number = vim.fn.line(".")
	local full_url = get_remote_base_url() .. "/blob/" .. branch_name .. "/" .. file_name .. "#L" .. line_number
	open_in_browser(full_url)
end, {})

vim.api.nvim_create_user_command("OpenCommit", function()
	local hash
	-- Walk upward from the cursor to find the header line for this commit block.
	-- Header lines contain a date (YYYY-MM-DD); continuation lines don't.
	local current_line_number = vim.fn.line(".")
	for i = current_line_number, 1, -1 do
		local line = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]
		if line:match("%d%d%d%d%-%d%d%-%d%d") then
			hash = line:match("%x+") -- first hex sequence on the line is the short hash
			break
		end
	end
	if not hash then
		vim.notify("No commit hash found on current line", vim.log.levels.WARN)
		return
	end
	local full_url = get_remote_base_url() .. "/commit/" .. hash
	open_in_browser(full_url)
end, {})

vim.api.nvim_create_user_command("CopyPath", function(opts)
	local use_abs_path = opts.args == "abs"
	local modifier = use_abs_path and "%:p" or "%:."
	local path = vim.fn.expand(modifier)
	if not use_abs_path then
		path = path:gsub("\\", "/")
	end
	vim.fn.setreg("+", path)
	vim.notify("Copied '" .. path .. "' to system clipboard")
end, { nargs = "?" })
