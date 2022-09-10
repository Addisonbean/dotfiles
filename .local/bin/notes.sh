#!/usr/bin/env bash

# TODO: also display tags for each note
# TODO: sort by date always, even after filter by tag
# TODO: previews...
# rg --json + jq ???
# rofi -e for errors

notes_dir=~/documents/notes

open-file() {
	(st -e nvim "$1") & disown
}

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
		(st -e nvim -s <(echo :e ~/documents/notes/)) & disown
		shift
	;;
	notes)
		note="$(ls -ct "$notes_dir" | rofi-dialog "Notes")"
		[ -n "$note" ] && open-file "$notes_dir/$note"
		shift
	;;
	tags)
		tag="$(rg --no-filename -e '^(:[^:]+)+:' "$notes_dir" | tr ':' '\n' | sort | uniq | sed '0,/^$/{//d}' | rofi-dialog "Tags")"
		if [ -n "$tag" ]; then
			note="$(rg ":${tag}:" "$notes_dir" | cut -d ':' -f 1 | xargs -n1 -d '\n' basename | uniq | rofi-dialog "Notes")"
			[ -n "$note" ] && open-file "$notes_dir/$note"
		fi
		shift
	;;
	untagged)
		note="$(rg --files-without-match -e '^(:[^:]+)+:' "$notes_dir" | xargs -n1 -d '\n' basename | rofi-dialog "Untagged Notes")"
		[ -n "$note" ] && open-file "$notes_dir/$note"
		shift
	;;
	esac
done
