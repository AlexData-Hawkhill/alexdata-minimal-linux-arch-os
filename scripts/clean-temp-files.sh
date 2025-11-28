bash#!/bin/bash
# clean-temp-files.sh - Complete system cleanup

# Welcome info !!
echo "------------------------------------"
echo "🧹 Starting Arch Linux cleanup... 🗑️"
echo "------------------------------------"

# Grant Admin Access!!
echo ""
echo "This script need admin/root access to clean everything properly"
sudo -i 

# 0. Show current disk space in use
echo "💾 Disk usage before cleaning:"
df -h / | tail -1
echo ""

# 1. Remove orphaned packages:
echo "🗑️  Removing orphaned packages..."
sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null || echo "No orphans found"
echo ""

# 2. Clean package cache (keep last 3 versions):
echo "📦 Cleaning package cache (keeping last 3 versions)..."
sudo paccache -r
echo ""

# 3. Clean pacman package cache (everything):
echo "🔧 Cleaning PACMAN cache..."
sudo pacman -Sc --noconfirm
echo ""

# 4. Clean paru/AUR cache (cleans even more than pacman does):
echo "🔧 Cleaning AUR cache..."
sudo paru -Sc --noconfirm
echo ""

# 5. Remove old journal logs (keep last 3 days):
echo "📜 Cleaning old logs..."
sudo journalctl --vacuum-time=3d
echo ""

# 6. Show disk space saved:
echo "💾 Disk usage after cleaning:"
df -h / | tail -1
echo ""

# 7. Python if user wants to delete that (present user with Y/n prompt for python - since rebuilding wheels take time!):
# Add logic for presenting user with a choice (e.g. read -p "select Y/n" + logic to handle that)
# PS: NB: NON SUDO COMMANDS (WE WANT TO DELETE USERS PIP CACHE - NOT EMPTY ROOT CACHE)
#exit
#pip cache dir        # Show folder location!
#pip cache info       # Show info on how much space it uses (do | grep for size: ?)
# PRESENT USER WITH CHOICE HERE - AFTER HAVING DISPLAYED SIZE INFO!
#pip cache purge      # Empty cache!
#pip cache remove *   # Completely empty cache!
#rm -rf ~/.cache/pip  # Empty and delete cache folder!

# Done !!
echo "✅ Cleanup complete!"
echo ""

# MAKE-THIS-SCRIPT-EXECUTABLE:
# bashchmod +x clean-temp-files.sh

# RUN-SCRIPT-IN-TERMINAL:
# ./clean-temp-files.sh
# sh clean-temp-files.sh
