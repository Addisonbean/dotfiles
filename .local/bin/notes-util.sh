export NOTES_DIR=~/documents/notes

nt-open-note() {
	(st -e nvim "$1") & disown
}
