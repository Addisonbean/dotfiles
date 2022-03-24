local colors = {
  -- black = '#282828',
  -- white = '#ebdbb2',
  -- red = '#fb4934',
  -- green = '#b8bb26',
  -- blue = '#83a598',
  -- yellow = '#fe8019',
  -- gray = '#a89984',
  -- darkgray = '#3c3836',
  -- lightgray = '#504945',
  -- inactivegray = '#7c6f64',

	red = '#ef2f27',
	green = '#519f50',
	blue = '#2c78bf',
	yellow = '#fbb829',
	magenta = '#ffee99',
	bg = '#1c1b19',
	fg = '#fce8c3',
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