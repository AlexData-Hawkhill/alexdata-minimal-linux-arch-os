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

# 3. Clean pacman package cache (everything temp that can be removed):
echo "🔧 Cleaning PACMAN cache..."
sudo pacman -Sc --noconfirm
echo ""

# 4. Clean paru/AUR cache (cleans even more temp than pacman does):
echo "🔧 Cleaning AUR cache..."
sudo paru -Sc --noconfirm
echo ""

# 5. Remove old journal logs (keep last 2 days):
echo "📜 Cleaning old logs..."
sudo journalctl --vacuum-time=2d
echo ""

# 6. Show disk space saved:
echo "💾 Disk usage after basic cleaning:"
df -h / | tail -1
echo ""

echo ""
echo "🎉 Basic Cache cleaning complete!"
echo ""

# 7. Clean pacman/paru/AUR package cache (complete delete! also delete stored packages!):
# Here is an example with two functions that check what is installed, and clean with those commands!
clean_package_cache() {
    echo "🔧 Advanced - Cleaning PACMAN, PARU, and AUR CACHE for all downloaded and stored packages..."
    
    # Check if pacman exists
    if command -v pacman &> /dev/null; then
        echo "📦 Found pacman installed - do you want to fully clean the pacman cache...?"
        read -p "Delete ALL pacman cached packages? (y/N): " USER_ANSWER
        USER_ANSWER=$(echo "$USER_ANSWER" | tr '[:upper:]' '[:lower:]')
        
        if [[ "$USER_ANSWER" == "y" || "$USER_ANSWER" == "yes" ]]; then
            sudo pacman -Scc --noconfirm
            echo "✅ Pacman cache completely cleaned!"
        else
            echo "⏭️  Pacman cache cleaning skipped."
        fi
    else
        echo "⚠️  Pacman not installed - auto skipping this step..."
    fi
    
    echo ""
    
    # Check if paru exists
    if command -v paru &> /dev/null; then
        echo "📦 Found paru installed  - do you want to fully clean the PARU AUR CACHE...?"
        read -p "Delete ALL paru aur cached packages? (y/N): " USER_ANSWER
        USER_ANSWER=$(echo "$USER_ANSWER" | tr '[:upper:]' '[:lower:]')
        
        if [[ "$USER_ANSWER" == "y" || "$USER_ANSWER" == "yes" ]]; then
            paru -Scc --noconfirm
            echo "✅ Paru cache completely cleaned!"
        else
            echo "⏭️  Paru cache cleaning skipped"
        fi
    else
        echo "⚠️  Paru not installed - auto skipping this step..."
    fi
    
    echo ""
    echo "🎉 Cache cleaning complete!"
}

# Call function to run it:
clean_package_cache    # The above function will now be executed!  



# 8. Python if user wants to delete that (present user with Y/n prompt for python - since rebuilding wheels take time!):
# PS: NB: USE NON SUDO COMMANDS (WE WANT TO DELETE USERS PIP CACHE - NOT ROOT's PIP CACHE)
#pip cache dir        # Show folder location!
#pip cache info       # Show info on how much space it uses (do | grep for size: ?)
#pip cache purge      # Empty cache!
#pip cache remove *   # Completely empty cache!
#rm -rf ~/.cache/pip  # Empty and delete cache folder!

exit # EXIT OUT OF ROOT !!

clean_python_pip_cache() {
    echo "🔧 Advanced - Cleaning PIP CACHE generated when building Python packages..."
    
    # Check if pip (python-pip package) exists
    if command -v pip &> /dev/null; then
        echo "📦 Found PIP for PYTHON installed - do you want to fully clean the PIP CACHE...?"
        echo ""
        pip cache dir        # Show folder location!
        pip cache info       # Show info on how much space it uses (do | grep for size: ?)
        echo ""
        read -p "Delete the whole PIP cache? (y/N): " USER_ANSWER
        USER_ANSWER=$(echo "$USER_ANSWER" | tr '[:upper:]' '[:lower:]')
        
        if [[ "$USER_ANSWER" == "y" || "$USER_ANSWER" == "yes" ]]; then
            pip cache purge      # Empty cache!
            rm -rf ~/.cache/pip  # Empty and delete cache folder!
            echo "✅ Python's PIP cache completely cleaned!"
        else
            echo "⏭️  Python's PIP cache cleaning skipped."
        fi
    else
        echo "⚠️  PIP for PYTHON not installed - auto skipping this step..."
    fi
    
    echo ""
}
# Call function to run it:
clean_python_pip_cache    # The above function will now be executed!



# 9. Show disk space saved:
echo "💾 Disk usage after advanced cleaning:"
df -h / | tail -1
echo ""

# Done !!
echo "✅ Cleanup complete!"
echo ""


# /var/cache/pacman/pkg/
# /var/lib/pacman/
# /root/.cache/paru/clone
# /root/.cache/paru/diff

# MAKE-THIS-SCRIPT-EXECUTABLE:
# bashchmod +x clean-temp-files.sh

# RUN-SCRIPT-IN-TERMINAL:
# ./clean-temp-files.sh
# sh clean-temp-files.sh


# This function can also be used - for even more finegrained control of python pip deletions!
better_clean_python_pip_cache() {
    echo "🔧 Advanced - Cleaning PIP CACHE generated when building Python packages..."
    
    # Check if pip (python-pip package) exists
    if command -v pip &> /dev/null; then
        echo "📦 Found PIP for PYTHON installed - do you want to fully clean the PIP CACHE...?"
        echo ""
        
        # Show cache info with size highlighted
        echo "📍 Cache location:"
        pip cache dir
        echo ""
        echo "📊 Cache statistics:"
        pip cache info | grep -E "(Location|Size)" || pip cache info
        echo ""
        
        read -p "Delete the whole PIP cache? (y/N): " USER_ANSWER
        USER_ANSWER=$(echo "$USER_ANSWER" | tr '[:upper:]' '[:lower:]')
        
        if [[ "$USER_ANSWER" == "y" || "$USER_ANSWER" == "yes" ]]; then
            echo "🧹 Purging pip cache..."
            pip cache purge 2>/dev/null || true
            
            echo "🧹 Removing cache directory..."
            rm -rf ~/.cache/pip 2>/dev/null || true
            
            echo "✅ Python's PIP cache completely cleaned!"
        else
            echo "⏭️  Python's PIP cache cleaning skipped."
        fi
    else
        echo "⚠️  PIP for PYTHON not installed - auto skipping this step..."
    fi
    
    echo ""
}

# Bonus: Check for pip3 too!
clean_python_pip_cache_extended() {
    # Call original function for pip
    clean_python_pip_cache
    
    # Also check pip3 (in case separate installation)
    if command -v pip3 &> /dev/null && ! command -v pip &> /dev/null; then
        echo "📦 Found PIP3 (but not pip) - cleaning pip3 cache..."
        pip3 cache purge 2>/dev/null || true
        rm -rf ~/.cache/pip 2>/dev/null || true
        echo "✅ Pip3 cache cleaned!"
    fi
}

# MAKE-THIS-SCRIPT-EXECUTABLE:
# bashchmod +x clean-temp-files.sh

# RUN-SCRIPT-IN-TERMINAL:
# ./clean-temp-files.sh
# sh clean-temp-files.sh
