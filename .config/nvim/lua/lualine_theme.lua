-- TODO: make this shared/only generate once
local fd = io.popen('xrdb -q')
local res = fd:read('*a')
fd:close()

local xres = {}
for k, v in string.gmatch(res, "([^%s:]+):%s*([^\n]+)") do
	xres[k] = v
end

local colors = {
	red = '#ff595e',
	green = '#8ac926',
	blue = '#1982c4',
	yellow = '#ffca4a',
	magenta = xres['ansi.color05'],
	-- What to do for these?
	-- bg = xres['vim.base0'],
	-- fg = xres['vim.base7'],
	-- fg = xres['vim.text-fg'],
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
