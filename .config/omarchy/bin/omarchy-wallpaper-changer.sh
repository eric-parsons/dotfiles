#!/usr/bin/sh
# Adapted from https://github.com/mpriem/omarchy-background-changer. Uses
# hyprpaper instead of swww.
#
# Dependencies: yay -S --needed hyprpaper && yay -S --needed socat
#
# Add "exec-once = hyprpaper" to autostart.conf before this script.


set -euo pipefail

while ! pgrep "hyprpaper" > /dev/null; do
    sleep 0.1
done

# Hack: There seems to be a race condition on startup that I can't track down.
# For now this is fine as long as you don't immediately switch workspaces.
sleep 2

# This will briefly flash the current wallpaper as set by Omarchy on every
# change if not disabled.
pkill -x swaybg || true

wallpaper_dir=$XDG_CONFIG_HOME/omarchy/current/theme/backgrounds

# TODO: Read from disk. Change logic so that it wraps if there are < 9 files
# (so if there are e.g. only 3 images, they would be 1 2 3 1 2 3 1 2 3).
declare -A WS_IMG=(
    [1]="$wallpaper_dir/blade-runner-1.jpg"
    [2]="$wallpaper_dir/blade-runner-2.jpg"
    [3]="$wallpaper_dir/blade-runner-3.jpg"
    [4]="$wallpaper_dir/blade-runner-4.jpg"
    [5]="$wallpaper_dir/blade-runner-5.jpg"
    [6]="$wallpaper_dir/blade-runner-6.jpg"
    [7]="$wallpaper_dir/blade-runner-7.jpg"
    [8]="$wallpaper_dir/blade-runner-8.jpg"
    [9]="$wallpaper_dir/blade-runner-9.jpg"
)
for img in "${WS_IMG[@]}"; do
    hyprctl hyprpaper preload $img
done

set_wall_for_monitor_ws() {
    local mon="$1" ws="$2" img="${WS_IMG[$ws]:-}"
    [[ -z "$img" ]] && return 0

    echo "[HYPR ACTION] Setting wallpaper for monitor '$mon' to workspace '$ws' image '$img'"
    hyprctl hyprpaper wallpaper "$mon,$img"
}

mapfile -t MON_WS < <(hyprctl -j monitors | jq -r '.[] | "\(.name)|\(.activeWorkspace.id)"')
for pair in "${MON_WS[@]}"; do
    mon="${pair%%|*}"
    ws="${pair##*|}"
    set_wall_for_monitor_ws "$mon" "$ws"
done

handle() {
    local evt="$1"
    echo "[HYPR EVENT] $evt"

    case "$evt" in
        focusedmonv2*)
            data="${evt#focusedmonv2>>}"
            mon="${data%%,*}"
            ws="${data##*,}"
            set_wall_for_monitor_ws "$mon" "$ws"
            ;;
        moveworkspacev2*)
            data="${evt#moveworkspacev2>>}"
            ws="${data%%,*}"
            mon="${data##*,}"
            set_wall_for_monitor_ws "$mon" "$ws"
            ;;
        workspacev2*)
            ws="${evt#workspacev2>>}"
            ws="${ws%%,*}"
            [[ "$ws" =~ ^[0-9]+$ ]] || ws="${evt#workspace>>}"
            mon="$(hyprctl -j monitors | jq -r '.[] | select(.focused).name')"
            [[ -n "$mon" && "$ws" =~ ^[0-9]+$ ]] && set_wall_for_monitor_ws "$mon" "$ws"
            ;;
    esac
}
SOCK="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
exec socat -U - "UNIX-CONNECT:$SOCK" | while IFS= read -r line; do handle "$line"; done
