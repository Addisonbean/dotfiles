export NOTES_DIR=~/documents/obsidian

nt-open-note() {
	(st -e nvim "$1") & disown
}
