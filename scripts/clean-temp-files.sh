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
paru -Sc --noconfirm
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
#bashpip cache purge
#pip cache remove *
#rm -rf ~/.cache/pip  

# Done !!
echo "✅ Cleanup complete!"
echo ""

# MAKE-THIS-SCRIPT-EXECUTABLE:
# bashchmod +x clean-temp-files.sh

# RUN-SCRIPT-IN-TERMINAL:
# ./clean-temp-files.sh
# sh clean-temp-files.sh
