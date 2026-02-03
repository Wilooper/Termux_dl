#!/data/data/com.termux/files/usr/bin/bash

# --- SETTINGS ---
DEST="/sdcard/Download/Termux"
LOG_FILE="$HOME/download_manager.log"
COOKIE_FILE="$HOME/instagram-cookies.txt"
mkdir -p "$DEST"

URL="$1"

# START LOGGING (This way is safer for all shells)
echo "------------------------------------------------" >> "$LOG_FILE"
echo "🕒 START: $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
echo "🔗 URL: $URL" >> "$LOG_FILE"

# --- PHASE 1: INSTAGRAM (The Cookie Priority) ---
# We use a simple 'case' check which never fails in any shell
case "$URL" in
    *instagram.com*)
        echo "[$(date '+%H:%M:%S')] ⚙️ IG Detected. Applying Cookies..." | tee -a "$LOG_FILE"
        if [ -f "$COOKIE_FILE" ]; then
            # We use --cookies-from-browser as a backup if file fails, 
            # but your text file is the primary key.
            yt-dlp --cookies "$COOKIE_FILE" \
                   -o "$DEST/%(uploader)s_%(id)s.%(ext)s" \
                   --no-mtime "$URL" 2>&1 | tee -a "$LOG_FILE"
        else
            echo "❌ ERROR: No cookies at $COOKIE_FILE" | tee -a "$LOG_FILE"
        fi
        exit 0
        ;;
esac

# --- PHASE 2: COBALT API (Public Links) ---
echo "[$(date '+%H:%M:%S')] ⚙️ Trying Cobalt API..." | tee -a "$LOG_FILE"
RESPONSE=$(curl -s -X POST "https://api.cobalt.tools/" \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -d "{\"url\": \"$URL\", \"videoQuality\": \"1080\"}")

DL_URL=$(echo "$RESPONSE" | jq -r '.url // empty')

if [ -n "$DL_URL" ] && [ "$DL_URL" != "null" ]; then
    echo "✅ API Success. Downloading..." | tee -a "$LOG_FILE"
    FILENAME="download_$(date +%s).mp4"
    curl -L -o "$DEST/$FILENAME" "$DL_URL" 2>&1 | tee -a "$LOG_FILE"
else
    # --- PHASE 3: GENERAL FALLBACK ---
    echo "⚠️ API failed. Using yt-dlp fallback..." | tee -a "$LOG_FILE"
    yt-dlp -o "$DEST/%(title)s.%(ext)s" \
           --no-mtime --embed-metadata "$URL" 2>&1 | tee -a "$LOG_FILE"
fi

echo "🕒 END: $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
