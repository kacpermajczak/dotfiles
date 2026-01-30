#!/bin/bash
CACHE_FILE="/tmp/tmux-weather-cache"

# Mapowanie warunków pogodowych na ikony Nerd Font
get_icon() {
  case "$1" in
    *Clear*|*Sunny*) echo "" ;;
    *Partly*) echo "" ;;
    *Cloud*|*Overcast*) echo "" ;;
    *Rain*|*Drizzle*|*Shower*) echo "" ;;
    *Snow*|*Sleet*|*Blizzard*) echo "" ;;
    *Fog*|*Mist*|*Haze*) echo "" ;;
    *Thunder*|*Storm*) echo "" ;;
    *Wind*) echo "" ;;
    *) echo "" ;;
  esac
}

# Zawsze najpierw zwroc cache (jesli istnieje)
if [[ -f "$CACHE_FILE" ]]; then
  cat "$CACHE_FILE"
else
  echo "..."
fi

# Sprawdz czy cache jest stary (>15 min) lub nie istnieje
if [[ ! -f "$CACHE_FILE" ]] || [[ -n $(find "$CACHE_FILE" -mmin +15 2>/dev/null) ]]; then
  # Odswiez w tle (non-blocking, cichy)
  (
    condition=$(curl -sf -m 5 'wttr.in?format=%C' 2>/dev/null)
    temp=$(curl -sf -m 5 'wttr.in?format=%t' 2>/dev/null)
    if [[ -n "$temp" ]]; then
      icon=$(get_icon "$condition")
      echo "$icon $temp" > "$CACHE_FILE"
    fi
  ) &>/dev/null &
fi
