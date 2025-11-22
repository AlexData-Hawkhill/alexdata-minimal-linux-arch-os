#
# ~/.bashrc
#

# If not running bash interactively, then don't do anything.
[[ $- != *i* ]] && return

# Color things nicely in Bash Terminals!
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

clear # EMPTY ALL OLD INFORMATION FROM BASH STDOUT (the terminal window)!!

echo ""
echo "AlexData .bashrc -- [$HOSTNAME/$USER]"
echo ""
echo "Func: security, re, rebashdistro, sysinfo, netinfo, bootowner, rebash, rebasher, catbash, readbash"
echo "Func: findfile <*file*>, findword <*airplan*>"
echo "Func: helper, commands, kommandoer, packs, packages"
echo ""
echo "Alias: cls, dir, copy, rename, ren, del, delete, copy, move, more, read"
echo "Alias: disk, partition, diskpart, bashstory, history"
echo "Alias: distro, sysinfo, netinfo, bootowner"
echo ""
echo "Logged on as user:" $USER "on the machine:" $HOSTNAME
USERPATH=$(pwd);#Sets the variable USERPATH to contain command PWD's output!
echo "You are located here right now: $USERPATH"
echo ""
#
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
alias read='cat'
#
# ALEXDATA SPECIAL ALIASES:
alias ls='ls -a'
alias cd..='cd ..'

# Show disk usage sorted by user folders:
alias usersize='echo ""; echo "Storage space used by << $USER >> for storing personal files: "; du -h --max-depth=1 | sort -h; echo ""'
alias size='echo ""; echo "This folder and its subfolders use this amount of storage space: "; du -sh; echo ""'

# List disks and partitions:
alias partitions='lsblk -f'
alias partition='lsblk -f'
alias diskparts='lsblk -f'
alias diskpart='lsblk -f'
alias disks='lsblk -f'
alias disk='lsblk -f'


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
  ((i%10==9)) && read -p "[Key]"
done
}


# The "commands" will list busybox/coreutils commandos in easy to read groups!
function commands {
mapfile -t cmds < <(compgen -c)
echo "NB: PS: Press CTRL+C to stop listing the commands!"
for ((i=0; i<${#cmds[@]}; i++)); do
  echo "${cmds[i]}"
  ((i%10==9)) && read -p "[Key]"
done
}

# The "helper" will list busybox/coreutils commandos in easy to read groups!
function helper {
echo "NB: PS: Press CTRL+C to stop listing the commands!"
mapfile -t cmds < <(compgen -c)
for ((i=0; i<${#cmds[@]}; i++)); do
  echo "${cmds[i]}"
  ((i%10==9)) && read -p "[Key]"
done
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

# ---------------------------------
# Quick file finder (shorter than typing find)
# Usage: findfile phpinfo
function ffile {
    find . -name "*$1*" 2>/dev/null
}

# Quick grep through files to find specific words
# Usage: findword "some text"
function fword {
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
}

# Quick system info:
function sysinfo {
    echo "System Information:"
    echo "  Distribution: $(cat /etc/os-release | grep "PRETTY_NAME" | cut -d'"' -f2)"
    echo "  Kernel: $(uname -r)"
    echo "  Uptime: $(uptime -p)"
    echo "  CPU: $(lscpu | grep "Model name" | cut -d':' -f2 | xargs)"
    echo "  Memory: $(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
    echo "  Disk: $(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')"
}

# Quick network info:
function netinfo {
    echo "Network Information:"
    echo "  Hostname: $HOSTNAME"
    echo "  Local IP: $(hostname -I | awk '{print $1}')"
    echo "  Gateway: $(ip route | grep default | awk '{print $3}')"
}

# Check boot ownership (for your doc!):
function bootowner {
    OWNER=$(ls -ld /boot | awk '{print $3}')
    echo "Boot partition owner: $OWNER"
}
