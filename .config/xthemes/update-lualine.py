#!/usr/bin/env python

import os
import re
import subprocess

VIM_CONFIG = os.path.expanduser('~/.config/nvim/lua/lualine_theme.lua')
XRDB_LINE_REGEX = re.compile(r'([^:]+):\s*(.+)')

def update_color(color, value):
	print('sed -i -E "s/^[[:space:]]*{} = .+/	{} = \'{}\',/" {}'.format(color, color, value, VIM_CONFIG))
	os.system('sed -i -E "s/^[[:space:]]*{} = .+/	{} = \'{}\',/" {}'.format(color, color, value, VIM_CONFIG))

xrdb = subprocess.Popen(['xrdb', '-q'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

xrdb_output = xrdb.stdout.read().decode('utf-8')

xrdb_values = {}

for line in xrdb_output.splitlines():
	(key, value) = XRDB_LINE_REGEX.match(line).groups()
	xrdb_values[key] = value

update_color('blue', xrdb_values['st.color4'])
update_color('green', xrdb_values['st.color2'])
update_color('yellow', xrdb_values['st.color3'])
update_color('red', xrdb_values['st.color1'])
update_color('bg', xrdb_values['st.background'])
update_color('fg', xrdb_values['st.foreground'])
