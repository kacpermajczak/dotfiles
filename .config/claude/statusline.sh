#!/bin/bash

# Combined Claude Code Status Line Script
# Features: ccusage.com integration + custom Git status, environment info, mood assistant
# Removes duplicates: token tracking, model display, session costs (handled by ccusage)

# Configuration
STATS_DIR="$HOME/.claude/statusline-stats"
SESSION_FILE="$STATS_DIR/current-session.json"
MOODS_FILE="$STATS_DIR/moods.json"

# Create stats directory if needed
mkdir -p "$STATS_DIR"

# Read input data from stdin and store it
input=$(cat)

# Extract data from the JSON input
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
project_dir=$(echo "$input" | jq -r '.workspace.project_dir // .workspace.current_dir')
output_style=$(echo "$input" | jq -r '.output_style.name // "default"')
session_id=$(echo "$input" | jq -r '.session_id // "unknown"')
transcript_path=$(echo "$input" | jq -r '.transcript_path // ""')

# Get project name from project directory
project_name=$(basename "$project_dir")

# Initialize session tracking
current_time=$(date +%s)
init_session() {
    echo "{\"session_id\":\"$session_id\",\"start_time\":$current_time,\"message_count\":0,\"last_response_time\":0}" > "$SESSION_FILE"
}

# Load or initialize session data
if [ ! -f "$SESSION_FILE" ] || [ "$(jq -r '.session_id // ""' "$SESSION_FILE" 2>/dev/null)" != "$session_id" ]; then
    init_session
fi

# Update session metrics
session_data=$(cat "$SESSION_FILE" 2>/dev/null || echo '{}')
start_time=$(echo "$session_data" | jq -r '.start_time // 0')
message_count=$(echo "$session_data" | jq -r '.message_count // 0')
last_response_time=$(echo "$session_data" | jq -r '.last_response_time // 0')

# Increment message count and update session file
new_message_count=$((message_count + 1))
echo "$session_data" | jq --arg count "$new_message_count" --arg time "$current_time" \
    '.message_count = ($count | tonumber) | .last_response_time = ($time | tonumber)' > "$SESSION_FILE"

# Calculate session duration
session_duration=$((current_time - start_time))
session_minutes=$((session_duration / 60))
session_seconds=$((session_duration % 60))

# Get ccusage statusline (handles token tracking, model display, costs)
get_ccusage_statusline() {
    # Pass the input JSON to ccusage statusline command
    ccusage_output=$(echo "$input" | bun x ccusage statusline 2>/dev/null)
    if [ $? -eq 0 ] && [ -n "$ccusage_output" ]; then
        echo "$ccusage_output"
    else
        # Fallback if ccusage is not available
        echo "\033[2;37mccusage unavailable\033[0m"
    fi
}

# Mood assistant
mood_assistant() {
    # Simple sentiment analysis based on recent activity patterns
    local mood_score=50  # neutral baseline
    
    # Analyze session activity (more messages = higher energy)
    if [ $new_message_count -gt 20 ]; then
        mood_score=$((mood_score + 20))
    elif [ $new_message_count -gt 10 ]; then
        mood_score=$((mood_score + 10))
    fi
    
    # Session duration factor (longer sessions might indicate focus)
    if [ $session_minutes -gt 60 ]; then
        mood_score=$((mood_score + 15))
    elif [ $session_minutes -gt 30 ]; then
        mood_score=$((mood_score + 5))
    fi
    
    # Time of day factor
    hour=$(date +%H)
    if [ $hour -ge 9 ] && [ $hour -le 17 ]; then
        mood_score=$((mood_score + 5))  # work hours
    elif [ $hour -ge 22 ] || [ $hour -le 6 ]; then
        mood_score=$((mood_score - 10))  # late/early hours
    fi
    
    # Generate mood message
    if [ $mood_score -ge 80 ]; then
        printf "\033[1;32m🚀 Produktywnie!\033[0m"
    elif [ $mood_score -ge 65 ]; then
        printf "\033[1;36m✨ Świetnie!\033[0m"
    elif [ $mood_score -ge 50 ]; then
        printf "\033[1;37m⚡ W rytmie\033[0m"
    elif [ $mood_score -ge 35 ]; then
        printf "\033[1;33m☕ Czas na kawę\033[0m"
    else
        printf "\033[1;35m🌙 Odpoczynek?\033[0m"
    fi
}

# Response time tracking
response_time_ms=0
if [ $last_response_time -gt 0 ]; then
    response_time_ms=$(((current_time - last_response_time) * 1000))
    if [ $response_time_ms -gt 5000 ]; then
        response_display=$(printf "\033[1;31m%.1fs\033[0m" $((response_time_ms / 1000)))
    elif [ $response_time_ms -gt 2000 ]; then
        response_display=$(printf "\033[1;33m%.1fs\033[0m" $((response_time_ms / 1000)))
    else
        response_display=$(printf "\033[1;32m%.1fs\033[0m" $((response_time_ms / 1000)))
    fi
else
    response_display="\033[2;37m--\033[0m"
fi

# Git status information with change count
git_info=""
if cd "$current_dir" 2>/dev/null && git rev-parse --git-dir >/dev/null 2>&1; then
    branch_name=$(git branch --show-current 2>/dev/null || git rev-parse --short HEAD 2>/dev/null || echo "detached")
    
    # Sanitize branch name for display (escape any problematic characters)
    branch_name=$(printf '%s' "$branch_name" | tr -d '\n\r')
    
    # Count changed files (staged + unstaged)
    changed_files=$(git status --porcelain 2>/dev/null | wc -l | xargs)
    
    # Check if there are any changes
    if [ "$changed_files" -gt 0 ]; then
        git_info=$(printf " \033[1;31m%s\033[0m \033[1;33m±%s\033[0m" "$branch_name" "$changed_files")
    else
        git_info=$(printf " \033[1;32m%s\033[0m \033[2;32m✓\033[0m" "$branch_name")
    fi
fi

# Environment detection
env_info=""

# Python virtual environment
if [ -n "$VIRTUAL_ENV" ]; then
    venv_name=$(basename "$VIRTUAL_ENV")
    python_version=$(python --version 2>/dev/null | cut -d' ' -f2 | cut -d'.' -f1-2)
    if [ -n "$python_version" ] && [ -n "$venv_name" ]; then
        env_info=$(printf "%s \033[1;36mpy:%s(%s)\033[0m" "$env_info" "$python_version" "$venv_name")
    fi
fi

# Node.js version (if package.json exists)
if [ -f "$current_dir/package.json" ]; then
    node_version=$(node --version 2>/dev/null | sed 's/^v//')
    if [ -n "$node_version" ]; then
        env_info=$(printf "%s \033[1;35mnode:%s\033[0m" "$env_info" "$node_version")
    fi
fi

# Go version (if go.mod exists)
if [ -f "$current_dir/go.mod" ]; then
    go_version=$(go version 2>/dev/null | awk '{print $3}' | sed 's/^go//')
    if [ -n "$go_version" ]; then
        env_info=$(printf "%s \033[1;34mgo:%s\033[0m" "$env_info" "$go_version")
    fi
fi

# Work mode indicator based on output style
mode_indicator=""
case "$output_style" in
    "Explanatory")
        mode_indicator=$(printf " \033[1;42m LEARN \033[0m")
        ;;
    "Learning")
        mode_indicator=$(printf " \033[1;43m TEACH \033[0m")
        ;;
    "default")
        mode_indicator=$(printf " \033[1;44m CODE \033[0m")
        ;;
    *)
        mode_indicator=$(printf " \033[1;46m %s \033[0m" "$output_style")
        ;;
esac

# Relative path from project root
if [ "$current_dir" != "$project_dir" ]; then
    # Use parameter expansion to safely remove project_dir prefix
    rel_path="${current_dir#$project_dir}"
    rel_path="${rel_path#/}"  # Remove leading slash if present
    if [ -n "$rel_path" ]; then
        path_display="${project_name}/\033[2;37m${rel_path}\033[0m"
    else
        path_display="$project_name"
    fi
else
    path_display="$project_name"
fi

# Work metrics display (message counter and response times)
work_metrics=$(printf "\033[1;94m#%d\033[0m \033[1;37m%02d:%02d\033[0m %s" \
    "$new_message_count" \
    "$session_minutes" \
    "$session_seconds" \
    "$response_display")

# Get ccusage statusline
ccusage_display=$(get_ccusage_statusline)

# Mood assistant display
mood_display=$(mood_assistant)

# Generate combined status line:
# [PROJECT/path] git_info | ccusage_output | msg# time response | env | mood | MODE
printf "\033[1;37m[\033[0m\033[1;33m%s\033[0m\033[1;37m]\033[0m%s \033[1;90m|\033[0m %s \033[1;90m|\033[0m %s%s \033[1;90m|\033[0m %s%s\n" \
    "$path_display" \
    "$git_info" \
    "$ccusage_display" \
    "$work_metrics" \
    "$env_info" \
    "$mood_display" \
    "$mode_indicator"