#!/usr/bin/env bash

# TODO: also display tags for each note
# TODO: sort by date always, even after filter by tag
# TODO: previews...
# rg --json + jq ???
# rofi -e for errors

source "$HOME/.local/bin/notes-util.sh"

rofi-dialog() {
	rofi -dmenu -sort -i -p "$1"
}

while [[ $# -gt 0 ]]; do
	case "$1" in
	commands)
		cmd="$(echo -e "new\nnotes\ntags\nuntagged" | rofi-dialog "Commands")"
		[ -n "$cmd" ] && "$0" "$cmd"
		shift
	;;
	new)
		(st -e nvim -s <(echo :e "$NOTES_DIR")) & disown
		shift
	;;
	notes)
		note="$(ls -ctp "$NOTES_DIR" | rofi-dialog "Notes")"
		[ -n "$note" ] && nt-open-note "$NOTES_DIR/$note"
		shift
	;;
	tags)
		# TODO: make this work for files inside subdirectories
		tag="$(rg --no-filename -e '^(:[^:]+)+:' "$NOTES_DIR" | tr ':' '\n' | sort | uniq | sed '0,/^$/{//d}' | rofi-dialog "Tags")"
		if [ -n "$tag" ]; then
			note="$(rg ":${tag}:" "$NOTES_DIR" | cut -d ':' -f 1 | xargs -n1 -d '\n' basename | uniq | rofi-dialog "Notes")"
			[ -n "$note" ] && nt-open-note "$NOTES_DIR/$note"
		fi
		shift
	;;
	untagged)
		note="$(rg --files-without-match -e '^(:[^:]+)+:' "$NOTES_DIR" | xargs -n1 -d '\n' basename | rofi-dialog "Untagged Notes")"
		[ -n "$note" ] && nt-open-note "$NOTES_DIR/$note"
		shift
	;;
	esac
done
