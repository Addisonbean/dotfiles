-- Allow saving and quiting when I'm still accidentally holding shift
vim.cmd 'command! WQ wq'
vim.cmd 'command! Wq wq'
vim.cmd 'command! W w'
vim.cmd 'command! Q q'
vim.cmd 'command! X x'

-- TODO: is this needed? Does neovim do this for me?
-- For the `PdfView` command
math.randomseed(os.time())

function _G.PdfView()
    local fname = tostring(math.random(0, 100000))
    -- TODO: use https://github.com/hishamhm/f-strings
    local cmd = '!pandoc -s % -o /tmp/' .. fname .. '.pdf && xdg-open /tmp/' .. fname .. '.pdf && rm /tmp/' .. fname .. '.pdf'
    os.execute(cmd)
end

vim.cmd 'command! Pdf call PdfView()'

-- Thanks to https://stackoverflow.com/a/4293538/1525759
-- function WriteCreatingDirs()
-- 	execute ':silent !mkdir -p %:h'
-- 	write
-- endfunction
-- command! WD call WriteCreatingDirs()

-- Open the current
-- TODO: use `open` when on macOS
-- command! Open !xdg-open %
