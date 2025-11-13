#!/usr/bin/env bash
# stat.sh - backup a specified file to Backup/ then remove original
# also installs a cron job to compress Backup/ daily at 17:00 and remove Backup/
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$SCRIPT_DIR/Backup"
DAILY_SCRIPT="$SCRIPT_DIR/backup_daily.sh"

# 1) Ask for the file path
read -p "Enter the full path of the file to backup and remove: " FILEPATH
if [ -z "$FILEPATH" ]; then
  echo "No file provided. Exiting."
  exit 1
fi

if [ ! -f "$FILEPATH" ]; then
  echo "File not found: $FILEPATH"
  exit 1
fi

# 2) Ensure Backup folder exists and copy file into it
mkdir -p "$BACKUP_DIR"
cp -v "$FILEPATH" "$BACKUP_DIR"/
echo "Copied $FILEPATH to $BACKUP_DIR"

# Remove original
rm -v "$FILEPATH"
echo "Removed original file: $FILEPATH"

# 3) Create daily backup script (that cron will run at 17:00)
cat > "$DAILY_SCRIPT" <<'EOF'
#!/usr/bin/env bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$DIR/Backup"
if [ -d "$BACKUP" ]; then
  DATE=$(date +%d%m%Y)
  ARCHIVE="$DIR/${DATE}.tar"
  tar -cf "$ARCHIVE" -C "$DIR" "$(basename "$BACKUP")"
  rm -rf "$BACKUP"
fi
EOF

chmod +x "$DAILY_SCRIPT"
echo "Created daily backup helper: $DAILY_SCRIPT"

# Install cron job (run backup_daily.sh at 17:00 every day)
CRON_LINE="0 17 * * * $DAILY_SCRIPT >/dev/null 2>&1"
# Add cron if not already present
( crontab -l 2>/dev/null | grep -F "$DAILY_SCRIPT" ) >/dev/null 2>&1 || (
  ( crontab -l 2>/dev/null || true; echo "$CRON_LINE" ) | crontab -
  echo "Installed cron job for daily backup at 17:00"
)

echo "stat.sh completed."
