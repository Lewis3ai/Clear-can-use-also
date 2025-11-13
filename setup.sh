#!/usr/bin/env bash
# setup.sh - installs required packages, clones repo, sets up virtualenv, runs flask init
set -e
SCRIPT_DIR="$(pwd)"

# Determine package manager and install python3, pip3, git
if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y python3 python3-venv python3-pip git
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y python3 python3-venv python3-pip git
elif command -v yum >/dev/null 2>&1; then
  sudo yum install -y python3 python3-venv python3-pip git
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -Sy --noconfirm python python-pip git
else
  echo "Unsupported package manager. Please install python3, pip3 and git manually."
  exit 1
fi

# Clone (or update) the repository
REPO="https://github.com/Snickdx/flaskSample.git"
DEST="flaskSample"

if [ -d "$DEST" ]; then
  echo "Repository folder exists. Pulling latest changes..."
  cd "$DEST"
  git pull
else
  git clone "$REPO" "$DEST"
  cd "$DEST"
fi

# Create Python virtual environment
python3 -m venv venv
# Activate for this script
source venv/bin/activate

# Upgrade pip and install requirements
pip install --upgrade pip
if [ -f requirements.txt ]; then
  pip install -r requirements.txt
fi

# Ensure gunicorn installed (required for production run)
pip install gunicorn

# Initialize the database according to README (flask init)
# Use python -m flask to ensure the local venv's flask is used
export FLASK_APP=main.py
python -m flask init || echo "flask init returned non-zero (if your app doesn't implement it, ignore)"

echo
echo "Setup complete. To run the app locally (development):"
echo "  cd $SCRIPT_DIR/$DEST"
echo "  source venv/bin/activate"
echo "  python -m flask run"
echo
echo "To run with gunicorn (production-like):"
echo "  source venv/bin/activate"
echo "  gunicorn main:app -b 0.0.0.0:8000 --workers 3"
