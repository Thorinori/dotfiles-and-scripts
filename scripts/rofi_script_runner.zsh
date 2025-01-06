#!/bin/zsh

rofi -e "$(zsh -c "$(rofi -config ~/.config/rofi/rofidmenu.rasi -dmenu -p 'Run command' -theme-str 'listview {lines: 0;}')" 2>&1 )" -config ~/.config/rofi/rofidmenu.rasi
#From https://www.reddit.com/r/i3wm/comments/lhilro/execute_a_command_from_rofi/
