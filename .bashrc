/*

THE PERFECT .BASHRC STRUCTURE:
bash#!/bin/bash
# ~/.bashrc

# ===========================================
# PART 1: ALWAYS LOADED (Functions, Variables)
# ===========================================

# Set locale first!
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Define all your functions here:
new_files() { ... }
old_files() { ... }
packages() { ... }
# ... etc ...

# ===========================================
# PART 2: INTERACTIVE-ONLY (Aliases, Welcome)
# ===========================================

# Stop here if not interactive:
[[ $- != *i* ]] && return

# Now your interactive-only stuff:
clear
echo "AlexData .bashrc -- [$HOSTNAME/$USER]"
# ... welcome messages ...
# ... aliases that use interactive features ...
timedatectl

/*


#
# ~/.bashrc
#

# If not running bash interactively, then don't do anything.
#[[ $- != *i* ]] && return

# Color things nicely in Bash Terminals!
alias ls='ls --color=auto'
alias grep='grep --color=auto'

#PS1='[\u@\h \W]\$ '

clear # EMPTY ALL OLD INFORMATION FROM BASH STDOUT (the terminal window)!!

echo ""
echo "AlexData .bashrc -- [$HOSTNAME/$USER]"
echo ""
echo "Linux: dircolors, sensors, cat, rm, rmdir, cp, users, groups, rsync, clear, touch"
echo ""
echo "Func: findfile <*file*>, findword <*airplan*>"
echo "Func: recent_files <number> [path], new_files <number> [path], old_files <number> [path]"
echo ""
echo "Func: repeat, re, rebash, basher, catbash, readbash, edit, bashedit, editbash, kateedit"
echo "Func: packs, packages, security, distro, sysinfo, netinfo, bootowner"
echo "Func: helper, commands, kommandoer, bashstory, history"
echo ""
echo "Alias: cls, dir, copy, rename, ren, del, delete, copy, move, more"
echo "Alias: mounted, disk, partition, diskpart"
echo "Alias: distro, sysinfo, netinfo, bootowner"
echo "Alias: size, usersize, lsd, ls"
echo ""
echo "Alias: home, root, desktop, local, config, media"
echo ""
echo "Hint: Type 're' or 'repeat' to see all this info again!"
echo ""
echo "Logged on as user:" $USER "on the machine:" $HOSTNAME
USERPATH=$(pwd);#Sets the variable USERPATH to contain command PWD's output!
echo "You are located here right now: $USERPATH"
echo ""
timedatectl # Display current time, this lets you check if local time is actually correct!
echo ""

# PATH ALIASES:
alias root='cd /; ls; echo ""'
alias home='cd ~/; ls; echo ""'
alias desktop='cd ~/Desktop/; ls; echo ""'
alias local='cd ~/.local/; ls; echo ""'
alias config='cd ~/.config/; ls; echo ""'
alias media='cd /run/media/$USER/; ls; echo ""'

# DOS ALIASES:
alias cls='clear'
alias dir='ls -lah'
alias copy='cp'
alias rename='mv'
alias ren='mv'
alias del='rm'
alias delete='rm'
alias move='mv'
alias more='cat'

# ALEXDATA SPECIAL LINUX ALIASES:
alias ls='ls -a  --color=auto'
alias lsd='ls -lah  --color=auto'
alias cd..='cd ..'

# Show disk usage sorted by user folders:
alias usersize='echo ""; echo "Storage space used by << $USER >> for storing personal files: "; du -h --max-depth=1 | sort -h; echo ""'
alias size='echo ""; echo "This folder and its subfolders use this amount of storage space: "; du -sh; echo ""'

# List disks and partitions:
alias partitions='echo ""; lsblk -f; echo ""; df -kh; echo ""'
alias partition='echo ""; lsblk -f; echo ""; df -kh; echo ""'
alias diskparts='echo ""; lsblk -f; echo ""; df -kh; echo ""'
alias diskpart='echo ""; lsblk -f; echo ""; df -kh; echo ""'
alias disks='echo ""; lsblk -f; echo ""; df -kh; echo ""'
alias disk='echo ""; lsblk -f; echo ""; df -kh; echo ""'


# List security on the current server/machine
function security {
mount | grep $(df . | tail -1 | awk '{print $1}')
}

# The "kommandoer" will list busybox/coreutils commandos in easy to read groups!
function kommandoer {
mapfile -t cmds < <(compgen -c)
echo "NB: PS: Press CTRL+C to stop listing the commands!"
for ((i=0; i<${#cmds[@]}; i++)); do
  echo "${cmds[i]}"
  ((i%10==9)) && read -p "[Displayed $i commands - Press any key to see 10 more - ctrl+c to exit]" && echo ""
done
echo ""
}


# The "commands" will list busybox/coreutils commandos in easy to read groups!
function commands {
mapfile -t cmds < <(compgen -c)
echo "NB: PS: Press CTRL+C to stop listing the commands!"
for ((i=0; i<${#cmds[@]}; i++)); do
  echo "${cmds[i]}"
  ((i%10==9)) && read -p "[Displayed $i commands - Press any key to see 10 more - ctrl+c to exit]" && echo ""
done
echo ""
}

# The "helper" will list busybox/coreutils commandos in easy to read groups!
function helper {
echo "NB: PS: Press CTRL+C to stop listing the commands!"
mapfile -t cmds < <(compgen -c)
for ((i=0; i<${#cmds[@]}; i++)); do
  echo "${cmds[i]}"
  ((i%10==9)) && read -p "[Displayed $i commands - Press any key to see 10 more - ctrl+c to exit]" && echo ""
done
echo ""
}


# ---------------------------------
# Restart bash easily!!
function rebash {
echo "Restarting bash..."
source ~/.bashrc
}

function basher {
echo "Restarting bash..."
source ~/.bashrc
}

function re {
echo "Restarting bash..."
source ~/.bashrc
}

function repeat {
echo "Restarting bash..."
source ~/.bashrc
}

# ---------------------------------
# Print bash to screen for easy fast reading!!
function catbash {
cat ~/.bashrc
}

function readbash {
cat ~/.bashrc
}

# ---------------------------------
# Print bash to screen for easy fast reading!!
function bashstory {
cat ~/.bash_history
}

function bashtory {
cat ~/.bash_history
}

function history {
cat ~/.bash_history
}

# ---------------------------------
# Edit bash quickly with nano!!
function bashedit {
nano ~/.bashrc
}

function editbash {
nano ~/.bashrc
}

function edit {
nano ~/.bashrc
}


function kateedit {
kate ~/.bashrc
echo "Document was opened in Kate Editor"
}


# ---------------------------------
# Function: recent_files <number> [path] - Find the files that just changed on the system!
recent_files() {
    local n=${1:-10}
    local path=${2:-/}
    sudo find "$path" -type f -exec stat --format '%Y :%y %n' {} \; 2>/dev/null \
        | sort -nr | head -n "$n" | cut -d: -f2-
}

# Function: new_files <number> [path] - Find the files that just changed on the system!
new_files() {
    local n=${1:-5}
    local path=${2:-/home/$USER}
    sudo find "$path" -type f -exec stat --format '%Y :%y %n' {} \; 2>/dev/null \
        | sort -nr | head -n "$n" | cut -d: -f2-
}

# Function: old_files <number> [path] - Find the oldest filechanges on the system!
old_files() {
    local n=${1:-5}
    local path=${2:-/home/$USER}
    sudo find "$path" -type f -exec stat --format '%Y :%y %n' {} \; 2>/dev/null \
        | sort -n | head -n "$n" | cut -d: -f2-
}


# ---------------------------------
# Quick file finder (shorter than typing find)
# Usage: findfile phpinfo
function findfile {
    find . -name "*$1*" 2>/dev/null
}

# Quick grep through files to find specific words
# Usage: findword "some text"
function findword {
    grep -r "$1" . 2>/dev/null
}


# ---------------------------------
# Get count of all installed packages (via pacman atleast)!!
function packages {
PACKS=$(pacman -Q | wc -l 2>&1)
if [ $? -eq 0 ]; then
    echo "Installed app packages: $PACKS"
    echo ""
else
    echo "Command Failed: $PACKS"
    echo ""
fi
#PKG_COUNT=$(pacman -Q | wc -l)
#echo ""; echo "Installed packages: $PKG_COUNT"; echo ""
}


# ---------------------------------
# Get count of all installed packages (via pacman atleast)!!
function packs {
PACKS=$(pacman -Q | wc -l 2>&1)
if [ $? -eq 0 ]; then
    echo "Installed app packages: $PACKS"
    echo ""
else
    echo "Command Failed: $PACKS"
    echo ""
fi
#PKG_COUNT=$(pacman -Q | wc -l)
#echo ""; echo "Installed packages: $PKG_COUNT"; echo ""
}



# ----------------------------------
# ----------------------------------
# Backup with timestamp:
TIMESTAMP=$(date +%d%m%Y_%H%M%S)
#cp important.txt important_backup_$TIMESTAMP.txt

# Check if command succeeded:
DISK_FREE=$(df -h / | tail -1 | awk '{print $4}')
#echo "Free space: $DISK_FREE"

# Store package count:
PKG_COUNT=$(pacman -Q | wc -l)
#echo "Installed packages: $PKG_COUNT"

# Get your user ID:
MY_UID=$(id -u)
#echo "Your UID: $MY_UID"


# Get your current Linux distribution:
function distro {
    cat /etc/os-release | grep "PRETTY_NAME" | cut -d'"' -f2
    echo ""
}

# Quick system info:
function sysinfo {
    echo ""
    echo "System Information:"
    echo "  Distribution: $(cat /etc/os-release | grep "PRETTY_NAME" | cut -d'"' -f2)"
    echo "  Kernel: $(uname -r)"
    echo "  Uptime: $(uptime -p)"
    echo "  CPU: $(lscpu | grep "Model name" | cut -d':' -f2 | xargs)"
    echo "  Memory: $(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
    echo "  Disk: $(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')"
    echo ""
}

# Quick network info:
function netinfo {
    echo ""
    echo "Network Information:"
    echo "Hostname: $HOSTNAME"
    #echo "Local IP: $(hostname -I | awk '{print $1}')"
    echo "Local IP:"
    echo "$(ip address | grep inet | awk '{print $2}')"
    echo "Gateway: $(ip route | grep default | awk '{print $3}')"
    echo ""
}

# Check boot and root ownership:
function bootowner {
    BOOT_OWNER=$(ls -ld /boot | awk '{print $3}')
    ROOT_OWNER=$(ls -ld / | awk '{print $3}')
    PART_OWNER=$(ls -ld /run | awk '{print $3}')
    echo "Boot  partition owner: $BOOT_OWNER"
    echo "Root  partition owner: $ROOT_OWNER"
    echo "Media partition owner: $PART_OWNER"
    echo ""
    lsblk | grep /    # List only mounted partitons!
    echo ""
}

# Check boot and root ownership:
function mounted {
    BOOT_OWNER=$(ls -ld /boot | awk '{print $3}')
    ROOT_OWNER=$(ls -ld / | awk '{print $3}')
    PART_OWNER=$(ls -ld /run | awk '{print $3}')
    echo "Boot  partition owner: $BOOT_OWNER"
    echo "Root  partition owner: $ROOT_OWNER"
    echo "Media partition owner: $PART_OWNER"
    echo ""
    lsblk | grep /    # List only mounted partitons!
    echo ""
}

# ----------------------------------
# ----------------------------------
## Always quote variables with spaces/newlines:
#FILES=$(ls)
#echo "$FILES"  # ← Quotes preserve formatting!

## Use $() instead of backticks (more readable):
#GOOD=$(pwd)     # Clear and nestable
#BAD=`pwd`       # Old style, harder to read

## Check if command succeeded:
#OUTPUT=$(some_command 2>&1)
#if [ $? -eq 0 ]; then
#    echo "Success: $OUTPUT"
#else
#    echo "Failed: $OUTPUT"
#fi
