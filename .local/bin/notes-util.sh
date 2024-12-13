export NOTES_DIR=~/documents/obsidian

nt-open-note() {
	(cd "$NOTES_DIR" && st -e nvim "$1") & disown
}
