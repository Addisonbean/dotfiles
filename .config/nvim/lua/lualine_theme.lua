local fd = io.popen('xrdb -q')
local res = fd:read('*a')
fd:close()

local xres = {}
for k, v in string.gmatch(res, "([^%s:]+):%s*([^\n]+)") do
	xres[k] = v
end

local colors = {
	-- TODO: Like make a vim.status_bar_insert var and stuff
	red = '#cc6666',
	green = '#8db866',
	blue = '#81a2be',
	yellow = '#f0c674',
	magenta = xres['ansi.color5'],
	bg = '#282a2e',
	fg = '#e0e0e0',
}

return {
  normal = {
    a = { bg = colors.blue, fg = colors.bg },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
    x = { bg = colors.bg, fg = colors.fg },
    y = { bg = colors.bg, fg = colors.fg },
    z = { bg = colors.fg, fg = colors.bg },
  },
  insert = {
    a = { bg = colors.green, fg = colors.bg },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
    x = { bg = colors.bg, fg = colors.fg },
    y = { bg = colors.bg, fg = colors.fg },
    z = { bg = colors.fg, fg = colors.bg },
  },
  visual = {
    a = { bg = colors.magenta, fg = colors.bg },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
    x = { bg = colors.bg, fg = colors.fg },
    y = { bg = colors.bg, fg = colors.fg },
    z = { bg = colors.fg, fg = colors.bg },
  },
  replace = {
    a = { bg = colors.red, fg = colors.bg },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
    x = { bg = colors.bg, fg = colors.fg },
    y = { bg = colors.bg, fg = colors.fg },
    z = { bg = colors.fg, fg = colors.bg },
  },
  command = {
    a = { bg = colors.blue, fg = colors.bg },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
    x = { bg = colors.bg, fg = colors.fg },
    y = { bg = colors.bg, fg = colors.fg },
    z = { bg = colors.fg, fg = colors.bg },
  },
  inactive = {
    a = { bg = colors.bg, fg = colors.fg },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
    x = { bg = colors.bg, fg = colors.fg },
    y = { bg = colors.bg, fg = colors.fg },
    z = { bg = colors.bg, fg = colors.fg },
  }
}
