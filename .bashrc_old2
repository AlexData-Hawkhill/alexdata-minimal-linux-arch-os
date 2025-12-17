# #
# # ~/.bashrc
# #

# # ====================================================
# # ℹ️🐧        INFO ABOUT BASH (ASH) (SH)          🐧ℹ️   
# # - ""/etc/bash.bashrc"" is the GLOBAL bashrc file  🔧
# # - ""~/.bashrc"" is your current users bashrc file 🔧
# # - Anything in "bash.bashrc" will be seen in TTY's 🔧
# # - "bash.bashrc" loads before users " .bashrc"     🔧
# # ====================================================
# USEFUL EMOJI'S: ℹ️ ❓ ❎ ❌ ↩️ ❕ ✅ ❔ ‼️ ⚠️ ☑️ ❗ 🔥 🔀 💾 💿 📀 🕸️ 🚧 📈 🔧



# # =============================================
# # PART 1: ALWAYS LOADED (System Variables)   🐧
# # - Double-clicking .sh file → Usually   YES ✅
# # - Running script with "bash file.sh" → YES ✅
# # - Terminal open with prompt →          YES ✅
# # - Typing commands manually →           YES ✅
# # =============================================

#PS1='[\u@\h \W]\$ '
PS1='\n\[\e[38;5;51m\]\t\[\e[0m\] \[\e[1;32m\]\u\[\e[0m\]@\[\e[1;33m\]\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\n\[\e[1;35m\]→\[\e[0m\] '

# # Set locale first!
# # Fixes locale errors in bash when using python and venv!
# # Also add to "sudo nano /etc/locale.conf" and possibly to the systemwide "/etc/bash.bashrc"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANG="${LANG:-en_US.UTF-8}"
export LC_TIME="${LC_TIME:-nb_NO.UTF-8}"
export LC_NUMERIC="${LC_NUMERIC:-nb_NO.UTF-8}"
export LC_MONETARY="${LC_MONETARY:-nb_NO.UTF-8}"
export LC_MEASUREMENT="${LC_MEASUREMENT:-nb_NO.UTF-8}"


# # ============================================
# # PART 2: ALWAYS LOADED (Functions)          🐧
# # - Double-clicking .sh file → Usually   YES ✅
# # - Running script with "bash file.sh" → YES ✅
# # - Terminal open with prompt →          YES ✅
# # - Typing commands manually →           YES ✅
# # ============================================

# ----------------------------------
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


# ----------------------------------
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


# ---------------------------------
# Get your current Linux distribution:
function distro {
    cat /etc/os-release | grep "PRETTY_NAME" | cut -d'"' -f2
    echo ""
}


# ---------------------------------
# List security on the current server/machine
function security {
mount | grep $(df . | tail -1 | awk '{print $1}')
}


# ---------------------------------
# The "findtool <part-of-name>" will list busybox/coreutils with that text in its name!
function findcmd {
compgen -c | grep "$1"
}



# The "findtool <part-of-name>" will list busybox/coreutils with that text in its name!
function findtool {
compgen -c | grep "$1"
}



# The "findtool <part-of-name>" will list busybox/coreutils with that text in its name!
function findcommand {
compgen -c | grep "$1"
}


# ---------------------------------
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
clear
echo "Restarting bash..."
source ~/.bashrc
}

function basher {
clear
echo "Restarting bash..."
source ~/.bashrc
}

function re {
clear
echo "Restarting bash..."
source ~/.bashrc
}

function repeat {
clear
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
}


# ---------------------------------
# Get info on named package (via packinfo <name>)
function packinfo {
PACKS=$(pacman -Qi $1 2>&1)
if [ $? -eq 0 ]; then
    echo ""
    echo -e "\e[38;5;118m"
    echo "PackInfo - Info About This Package:"
    echo ""
    echo "$PACKS"
    echo -e "\e[0m"
    echo ""

else
    echo -e "\e[38;5;196m"
    echo "PackInfo - Could not find the package you searched for: ''$1''"
    echo -e "\e[0m"
    echo ""
fi
}


# ---------------------------------
# Get info on named package (via pacinf <name>)
function pacinf {
PACKS=$(pacman -Qi $1 2>&1)
if [ $? -eq 0 ]; then
    echo ""
    echo -e "\e[38;5;118m"
    echo "PacInf - Info About This Package:"
    echo ""
    echo "$PACKS"
    echo -e "\e[0m"
    echo ""
else
    echo -e "\e[38;5;196m"
    echo "PacInf - Could not find the package you searched for: ''$1''"
    echo -e "\e[0m"
    echo ""
fi
}


# # ============================================================
# # PART 3: STOP LOADING .bashrc IF NOT INTERACTIVELY RUNNING 🐧
# # # # - Prompt showing [user@host]$ = Means It's Interactive!!
# # - Terminal open with prompt →         YES!                ✅
# # - Typing commands manually →          YES!                ✅
# # - Double-clicking .sh file →   Usually NO                 ❌
# # - Running script with "bash file.sh" → NO                 ❌
# # ============================================================
[[ $- != *i* ]] && return




# # ===============================================
# # PART 4: INTERACTIVE-ONLY (DOS & ARCH ALIASES) 🐧
# # - Prompt showing [user@host]$ = Interactive  !!
# # - Terminal open with prompt →         YES!   ✅
# # - Typing commands manually →          YES!   ✅
# # - Double-clicking .sh file →   Usually NO    ❌
# # - Running script with "bash file.sh" → NO    ❌
# # ===============================================

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

# ARCH ALIASES:
alias ls='ls --color=auto'   # Colors in Terminal Emulators.
alias grep='grep --color=auto'   # Colors in Terminal Emulators.



# # ===============================================
# # PART 5: INTERACTIVE-ONLY (HOST BASED ALIASES)🐧
# # - Prompt showing [user@host]$ = Interactive  !!
# # - Terminal open with prompt →         YES!   ✅
# # - Typing commands manually →          YES!   ✅
# # - Double-clicking .sh file →   Usually NO    ❌
# # - Running script with "bash file.sh" → NO    ❌
# # ===============================================

# Get current hostname - Apply aliases based on hostname:
CURRENT_HOST=$(hostname)

if [[ "$CURRENT_HOST" == "arch-alexdata" ]]; then
    # Arch-specific aliases
    alias update='sudo pacman -Syu'
    alias install='sudo pacman -S'
    alias search='pacman -Ss'
    echo "🐧 Arch aliases loaded!"

elif [[ "$CURRENT_HOST" == "alpine-server" ]]; then
    # Alpine-specific aliases
    alias update='sudo apk update && sudo apk upgrade'
    alias install='sudo apk add'
    alias commit='lbu commit'
    echo "🏔️ Alpine aliases loaded!"

elif [[ "$CURRENT_HOST" == "ubuntu-laptop" ]]; then
    # Ubuntu-specific aliases
    alias update='sudo apt update && sudo apt upgrade'
    alias install='sudo apt install'
    echo "🟠 Ubuntu aliases loaded!"

else
    # Generic Linux fallback
    echo "❓ Unknown host: $CURRENT_HOST"
fi




# # ===============================================
# # PART 6: INTERACTIVE-ONLY (USER BASED ALIASES) 🐧
# # - Prompt showing [user@host]$ = Interactive  !!
# # - Terminal open with prompt →         YES!   ✅
# # - Typing commands manually →          YES!   ✅
# # - Double-clicking .sh file →   Usually NO    ❌
# # - Running script with "bash file.sh" → NO    ❌
# # ===============================================

# Get current username
CURRENT_USER=$(username)

# ROOT SPECIFIC ALIASES:
if [[ "$CURRENT_USER" == "root" ]]; then

    alias home='/root/'
    echo "🐧🐧🐧 root aliases loaded!"

# ALEXDATA.COM SERVER SPECIFIC ALIASES:
elif [[ "$CURRENT_USER" == "alexdata.com" ]]; then
    alias home='/wwwroot/'
    echo "🐧🐧 alexdata.com server aliases loaded!"

# ALEXDATA LOCAL SPECIFIC ALIASES:
elif [[ "$CURRENT_USER" == "alexdata" ]]; then
    # PATH ALIASES:
    alias root='cd /; ls; echo ""'
    alias home='cd ~/; ls; echo ""'
    alias desktop='cd ~/Desktop/; ls; echo ""'
    alias local='cd ~/.local/; ls; echo ""'
    alias config='cd ~/.config/; ls; echo ""'
    alias media='cd /run/media/$USER/; ls; echo ""'

    # ALEXDATA SPECIAL LINUX ALIASES:
    alias ls='ls -a  --color=auto'
    alias lsd='ls -lah  --color=auto'
    alias cd..='cd ..'

    alias home='/home/alexdata/'
    echo "🐧🐧 alexdata aliases loaded!"

# GUEST SPECIFIC ALIASES:
elif [[ "$CURRENT_USER" == "guest" ]]; then
    alias home='/home/guest/'
    echo "🐧 guest aliases loaded!"

# Generic Linux fallback for unknown new usernames:
else
    alias home='/home/unknown/'
    echo "❓ Unknown user: $CURRENT_USER - Standard aliases loaded."
fi




# # ===============================================
# # PART 7: INTERACTIVE-ONLY (USEFUL FOR EVERYONE)🐧
# # - Prompt showing [user@host]$ = Interactive  !!
# # - Terminal open with prompt →         YES!   ✅
# # - Typing commands manually →          YES!   ✅
# # - Double-clicking .sh file →   Usually NO    ❌
# # - Running script with "bash file.sh" → NO    ❌
# # ===============================================

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

# Run pure bash (no profiles loaded!)
alias cleanbash='bash --noprofile --norc'
alias purebash='bash --noprofile --norc'
alias onlybash='bash --noprofile --norc'



# # ===============================================
# # PART 8: INTERACTIVE-ONLY (USER INFO MESSAGES) 🐧
# # - Prompt showing [user@host]$ = Interactive  !!
# # - Terminal open with prompt →         YES!   ✅
# # - Typing commands manually →          YES!   ✅
# # - Double-clicking .sh file →   Usually NO    ❌
# # - Running script with "bash file.sh" → NO    ❌
# # ===============================================
echo ""
echo ""
echo "AlexData .bashrc -- [$HOSTNAME/$USER]"
echo ""
echo "Linux: cp, clear,  cat, rm, rmdir, users, groups, touch"
echo "Linux: whereis, which, whoami, sensors, dircolors"
echo ""
echo "ERR: recent_files <number> [path], new_files <number> [path], old_files <number> [path]"
echo "Func: findfile <*file*>, findword <*airplan*>"
echo "Func: findcmd <part-of-name>, findtool <part-of-name>, findcommand <part-of-name>"
echo ""
echo "Func: repeat, re, rebash, basher, catbash, readbash"
echo "Func: edit, bashedit, editbash, kateedit"
echo "Func: packs, packages, security, distro, sysinfo, netinfo, bootowner"
echo "Func: helper, commands, kommandoer, bashstory, history"
echo ""
echo "Alias: cls, dir, copy, rename, ren, del, delete, copy, move, more"
echo "Alias: mounted, disk, partition, diskpart"
echo "Alias: distro, sysinfo, netinfo, bootowner"
echo "Alias: size, usersize, lsd, ls"
echo "Alias: cleanbash, purebash, onlybash"
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
echo ""




# # =============================================⚠️
# # PART 8: INTERACTIVE-ONLY -- TESTING FUNCTIONS⛓️‍💥
# # - Prompt showing [user@host]$ = Interactive  !!
# # - Terminal open with prompt →         YES!   ✅
# # - Typing commands manually →          YES!   ✅
# # - Double-clicking .sh file →   Usually NO    ❌
# # - Running script with "bash file.sh" → NO    ❌
# # =============================================⚠️

# ----------------------------------⚠️
# FUNCTIONS CURRENTLY NOT WORKING CORRECTLY !!!
# ----------------------------------⚠️
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


x_files() {
    local n="${1:-5}"
    local path="${2:-/home/$USER}"

    echo "Searching for $n most recent files in: $path"
    echo "---"

    sudo find "$path" -type f -printf '%T@ %TY-%Tm-%Td %TH:%TM:%TS %p\n' 2>/dev/null \
        | sort -rn \
        | head -n "$n" \
        | cut -d' ' -f2-
}
# ---------------------------------
# THIS PART OF IT WORKS: find "/home/alexdata/Desktop/" -type f | sort -nr | head -10 | cut -d: -f2-
# -nr = numeric,reverse || head/tail -10 = 10 newest/oldest || -d: = delimiter || -f2- = possible field 2
# ---------------------------------



# ----------------------------------⚠️
# FUNCTIONS CURRENTLY NOT IN USE !!!
# ----------------------------------⚠️
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
