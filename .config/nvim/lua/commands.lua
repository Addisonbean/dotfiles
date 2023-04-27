-- Allow saving and quiting when I'm still accidentally holding shift
vim.cmd 'command! WQ wq'
vim.cmd 'command! Wq wq'
vim.cmd 'command! QA qa'
vim.cmd 'command! Qa qa'
vim.cmd 'command! W w'
vim.cmd 'command! Q q'
vim.cmd 'command! X x'

-- TODO: is this needed? Does neovim do this for me?
-- For the `PdfView` command
math.randomseed(os.time())

function PdfView(fpath)
    -- TODO: use https://github.com/hishamhm/f-strings

    local delete = false
    if fpath == nil then
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
vim.api.nvim_create_user_command('Preview', function() PdfView() end , {})
vim.api.nvim_create_user_command('MakePdf', function(opts) PdfView(opts.args) end, { nargs = 1 })

-- Thanks to https://stackoverflow.com/a/4293538/1525759
-- function WriteCreatingDirs()
-- 	execute ':silent !mkdir -p %:h'
-- 	write
-- endfunction
-- command! WD call WriteCreatingDirs()

-- Open the current
-- TODO: use `open` when on macOS
-- command! Open !xdg-open %
