#!/bin/bash

# Configuration
CONFIG_DIR="$HOME/.config/shrtrun"
CONFIG_FILE="$CONFIG_DIR/config.conf"

# Create config directory if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Create default config if it doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
    cat > "$CONFIG_FILE" << EOF
# Quick Launcher Configuration
log_file: /logs/shrtrun.log
search_engine: https://duckduckgo.com/?q=
youtube_search: https://www.youtube.com/results?search_query=
EOF
fi

# Function to read config values
get_config_value() {
    key=$1
    default=$2
    # Use awk for more reliable parsing with : as delimiter
    value=$(awk -F': ' -v key="$key" '$1 == key {print $2}' "$CONFIG_FILE")
    if [ -z "$value" ]; then
        echo "$default"
    else
        echo "$value"
    fi
}

save_to_history() {
    cmd="$1"
    LAST_HISTORY=$(tail -n 1 "$HISTORY_FILE" 2>/dev/null)
    if [ "$cmd" != "$LAST_HISTORY" ]; then
        echo "$cmd" >> "$HISTORY_FILE"
    fi
}

# Get configuration values
SEARCH_ENGINE=$(get_config_value "search_engine" "https://duckduckgo.com/?q=")
YOUTUBE_SEARCH=$(get_config_value "youtube_search" "https://www.youtube.com/results?search_query=")
LOG_FILE=$(get_config_value "log_file" "/.logs/shrtrun.log")
HISTORY_FILE="$CONFIG_DIR/history.txt"

# Create history file if it doesn't exist
touch "$HISTORY_FILE"

# Check if log file exists
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi

# Function to show notifications
show_notification() {
    title="$1"
    message="$2"
    
    if command -v notify-send &> /dev/null; then
        notify-send "$title" "$message"
    else
        echo "$title: $message" >> "$LOG_FILE"
    fi
}

# Get user input from rofi
USER_INPUT=$(tac "$HISTORY_FILE" | rofi -dmenu -p "Run:")

# Exit if user didn't enter anything
if [ -z "$USER_INPUT" ]; then
    exit 0
fi

# Log the input
echo "$(date): User input: '$USER_INPUT'" >> "$LOG_FILE"

# Source the environment
source "$HOME/.profile" 2>/dev/null
source "$HOME/.bashrc" 2>/dev/null
source "$HOME/.bashrc_aliases" 2>/dev/null


# Check for command
if [[ "$USER_INPUT" == \!* ]]; then
    # Extract command type and query
    CMD_TYPE="${USER_INPUT:1:1}"
    QUERY="${USER_INPUT:2}"
    
    case "$CMD_TYPE" in
        g)
            # Format the search URL
            SEARCH_URL="${SEARCH_ENGINE}${QUERY// /+}"
            echo "$(date): Opening search URL: $SEARCH_URL" >> "$LOG_FILE"
            xdg-open "$SEARCH_URL" &> /dev/null &
            disown
            # Append to history
            save_to_history "$USER_INPUT"
            ;;
        y)
            # YouTube search
            YOUTUBE_URL="${YOUTUBE_SEARCH}${QUERY// /+}"
            echo "$(date): Opening YouTube search: $YOUTUBE_URL" >> "$LOG_FILE"
            xdg-open "$YOUTUBE_URL" &>/dev/null &
            disown
            # Append to history
            save_to_history "$USER_INPUT"
            ;;
        *)
            show_notification "Unknown Command" "The command '$CMD_TYPE' is not recognized"
            ;;
    esac
else
    # Execute regular command
    echo "$(date): Executing command: $USER_INPUT" >> "$LOG_FILE"
    
    # Execute in background and disown
    if eval "$USER_INPUT" &>/dev/null & then
        disown
        save_to_history "$USER_INPUT"
    else
        show_notification "Command Failed" "'$USER_INPUT' could not be executed."
    fi
fi