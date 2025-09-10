-- Allow saving and quiting when I'm still accidentally holding shift
vim.cmd 'command! WQ wq'
vim.cmd 'command! Wq wq'
vim.cmd 'command! QA qa'
vim.cmd 'command! Qa qa'
vim.cmd 'command! W w'
vim.cmd 'command! Q q'
vim.cmd 'command! X x'

-- For the `PdfView` command
math.randomseed(os.time())

function PdfView(fpath)
    local delete = false
    if fpath == nil or fpath == '' then
	local number = tostring(math.random(0, 100000))
	fpath = '/tmp/' .. number .. '.pdf'
	delete = true
    end

    local cmd = '!pandoc -s % -o ' .. fpath .. ' && xdg-open ' .. fpath
    if delete then
	cmd = cmd .. ' && rm ' .. fpath
    end

    vim.cmd(cmd)
end

vim.api.nvim_create_user_command('MakePdf', function(opts) PdfView(opts.args) end, { nargs = '?' })
