######### THE PERFECT .BASHRC STRUCTURE:

# #
# # ~/.bashrc
# #

# # ====================================================
# # ℹ️🐧        INFO ABOUT BASH (ASH) (SH)           🐧ℹ️
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


# ----------------
# CHANGING THE BASH PROMPTs LOOK - ADDING COLORS AND CLOCK
#PS1='[\u@\h \W]\$ '
#PS1='\n\[\t \u@\h \W\]\$ '
#PS1='\n\[\e[38;5;51m\]\t\[\e[0m\] \[\e[1;32m\]\u\[\e[0m\]@\[\e[1;33m\]\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\n\[\e[1;35m\]→\[\e[0m\] '
#PS1='\n\[\e[38;5;51m\]\t\[\e[0m\] \[\e[1;33m\]\u\[\e[0m\]@\[\e[1;33m\]\h\[\e[0m\]:\[\e[38;5;51m\]\w\[\e[0m\] '
#PS1='\n\[\e[1;34m\]\t\[\e[0m\] \[\e[38;5;34m\]\u\[\e[0m\]@\[\e[38;5;34m\]\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\] '
#
CURRENT_USER=$(whoami)
if [[ "$CURRENT_USER" == "root" ]]; then
# ADMIN:
PS1='\n\[\e[38;5;51m\]\t\[\e[0m\] \[\e[1;33m\]\u\[\e[0m\]@\[\e[1;33m\]\h\[\e[0m\]:\[\e[38;5;51m\]\w\[\e[0m\] '
fi
if [[ "$CURRENT_USER" == "alexdata" ]]; then
# USER:
PS1='\n\[\e[1;34m\]\t\[\e[0m\] \[\e[38;5;34m\]\u\[\e[0m\]@\[\e[38;5;34m\]\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\] '
fi
# ================


# ----------------
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
# ================



# # ============================================
# # PART 2: ALWAYS LOADED (Functions)          🐧
# # - Double-clicking .sh file → Usually   YES ✅
# # - Running script with "bash file.sh" → YES ✅
# # - Terminal open with prompt →          YES ✅
# # - Typing commands manually →           YES ✅
# # ============================================

# ================
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
# ----------------


# ================
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
# ----------------


# ================
# Check mounted mounts boot and root ownership:
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
} # Aliases for this function:
alias bootowner='mounted'
alias mounts='mounted'
# ----------------


# ================
# Get your current Linux distribution:
function distro {
    cat /etc/os-release | grep "PRETTY_NAME" | cut -d'"' -f2
    echo ""
}
# ----------------


# ================
# List security on the current server/machine
function security {
mount | grep $(df . | tail -1 | awk '{print $1}')
}
# ----------------



# ================
# The "findtool <part-of-name>" will list busybox/coreutils with that text in its name!
function findtool {
compgen -c | grep "$1"
} # Aliases for this function:
alias findcmd='findtool'
alias findcommand='findtool'
# ----------------



# ================
# The "helper" will list busybox/coreutils commandos in easy to read groups!
function helper {
echo "NB: PS: Press CTRL+C to stop listing the commands!"
mapfile -t cmds < <(compgen -c)
for ((i=0; i<${#cmds[@]}; i++)); do
  echo "${cmds[i]}"
  ((i%10==9)) && read -p "[Displayed $i commands - Press any key to see 10 more - ctrl+c to exit]" && echo ""
done
echo ""
} # Aliases for this function:
#kommandoer, commands
alias coreutils='helper'
alias busybox='helper'
alias commandhelp='helper'
alias cmdhelp='helper'
alias cu='helper'
alias bb='helper'
# ----------------



# ================
# Restart bash to apply edited .bashrc config file easily!!
function rebash {
clear
echo "Restarting bash..."
source ~/.bashrc
} # Aliases for this function:
alias repeat='rebash'
alias basher='rebash'
alias re='rebash'
alias rex='source /home/alexdata/.bashrc'
# ----------------



# ================
# Print bash to screen for easy fast reading!!
function readbash {
cat ~/.bashrc
echo ""; echo "--ABOVE IS THE ACTUAL CONTENT OF YOUR ~/.bashrc FILE--"
} # Aliases for this function:
alias catbash='readbash'
alias reba='readbash'
# ----------------



# ================
# Print bash commands history to screen for easy fast reading!!
function bashstory {
cat -n ~/.bash_history | tac
echo ""; echo "--ABOVE IS THE HISTORY OF BASH COMMANDS YOU'VE USED LATELY--"
} # Aliases for this function:
alias bashtory='bashstory'
alias history='bashstory'
# ----------------



# ================
# Edit bash quickly with nano!!
function editbash {
nano ~/.bashrc
} # Aliases for this function:
alias bashedit='editbash'
alias ebash='editbash'
# ----------------



# ================
# Edit bash quickly with kate!!
function edit {
nano ~/.bashrc
echo "Document was opened in Kate Editor"
} # Aliases for this function:
alias kateedit='edit'
alias kedit='edit'
# ----------------



# ================
# Quick file finder (shorter than typing find)
# Usage: findfile phpinfo
function findfile {
    find . -name "*$1*" 2>/dev/null
} # Aliases for this function:
alias fifi='findfile'
alias ff='findfile'
# ----------------



# ================
# Quick grep through files to find specific words
# Usage: findword "some text"
function findword {
    grep -r "$1" . 2>/dev/null
} # Aliases for this function:
alias fiwo='findword'
alias fw='findword'
# ----------------



# ================
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
} # Aliases for this function:
alias packs='packages'
alias packcount='packages'
# ----------------



# ================
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
} # Aliases for this function:
alias pacinf='packinfo'
alias=pain='packinfo'
alias=pinf='packinfo'
alias pi='packinfo'
# ----------------



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

# # Get current hostname - Apply aliases based on hostname:
# CURRENT_HOST=$(hostname)
#
# if [[ "$CURRENT_HOST" == "arch-alexdata" ]]; then
#     # Arch-specific aliases
#     alias update='sudo pacman -Syu'
#     alias install='sudo pacman -S'
#     alias search='pacman -Ss'
#     echo "🐧 Arch aliases loaded!"
#
# elif [[ "$CURRENT_HOST" == "alpine-server" ]]; then
#     # Alpine-specific aliases
#     alias update='sudo apk update && sudo apk upgrade'
#     alias install='sudo apk add'
#     alias commit='lbu commit'
#     echo "🏔️ Alpine aliases loaded!"
#
# elif [[ "$CURRENT_HOST" == "ubuntu-laptop" ]]; then
#     # Ubuntu-specific aliases
#     alias update='sudo apt update && sudo apt upgrade'
#     alias install='sudo apt install'
#     echo "🟠 Ubuntu aliases loaded!"
#
# else
#     # Generic Linux fallback
#     echo "❓ Unknown host: $CURRENT_HOST"
# fi




# # ===============================================
# # PART 6: INTERACTIVE-ONLY (USER BASED ALIASES) 🐧
# # - Prompt showing [user@host]$ = Interactive  !!
# # - Terminal open with prompt →         YES!   ✅
# # - Typing commands manually →          YES!   ✅
# # - Double-clicking .sh file →   Usually NO    ❌
# # - Running script with "bash file.sh" → NO    ❌
# # ===============================================

# Get current username
CURRENT_USER=$(whoami)

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

    # ALEXDATA USER ALIASES
    alias beuser='sudo -i -u alexdata'
    alias beroot='sudo -i -u root'
    alias becomeuser='sudo -i -u alexdata'
    alias becomeroot='sudo -i -u root'

    # ALEXDATA SPECIAL LINUX ALIASES:
    alias ls='ls -a  --color=auto'
    alias lsd='ls -lah  --color=auto'
    alias cd..='cd ..'

    # ECHO INFO
    echo "🐧 alexdata aliases loaded! 🐧"

# GUEST SPECIFIC ALIASES:
elif [[ "$CURRENT_USER" == "guest" ]]; then
    alias home='/home/guest/'
    echo "🐧 guest aliases loaded!"

# Generic Linux fallback for unknown or new usernames:
else
    echo "❓ Unknown user: $CURRENT_USER - If you see this message then your user was not correctly detected by ~/.bashrc!"
fi




# # ===============================================
# # PART 7: INTERACTIVE-ONLY (USEFUL FOR EVERYONE)🐧
# # - Prompt showing [user@host]$ = Interactive  !!
# # - Terminal open with prompt →         YES!   ✅
# # - Typing commands manually →          YES!   ✅
# # - Double-clicking .sh file →   Usually NO    ❌
# # - Running script with "bash file.sh" → NO    ❌
# # ===============================================

# Quick take-notes >> note <text>
# Quick to-do-soon >> soon <text>
# Read with "catnote" and "catsoon"
alias note='echo >> /mynote'
alias soon='echo >> /mysoon'
alias editnote='nano /mynote'
alias editsoon='nano /mysoon'
alias catnote='echo "/mynote content:"; echo ""; cat /mynote'
alias catsoon='echo "/mysoon content:"; echo ""; cat /mysoon'
# Create Note Files: sudo touch /mynote; touch /mysoon; chmod goa+rw /mynote; chmod goa+rw /mysoon; chown alexdata:alexdata /mysoon;

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

# Run pure bash (no profiles loaded!):
alias cleanbash='bash --noprofile --norc'
alias purebash='bash --noprofile --norc'
alias onlybash='bash --noprofile --norc'

# Arch Internet Status / On / Off:
alias internet='echo ""; echo "--INTERNET CONNECTION STATUS--"; nmcli device status'
alias interoff='echo ""; echo "--TURN INTERNET OFF--"; sudo nmcli n off; sleep 3; nmcli device status; sleep 3; nmcli device status'
alias interon='echo ""; echo "--TURN INTERNET ON--"; sudo nmcli n on; sleep 3; nmcli device status; sleep 3; nmcli device status'
alias internetoff='echo ""; echo "--TURN INTERNET OFF--"; sudo nmcli n off; sleep 3; nmcli device status; sleep 3; nmcli device status'
alias interneton='echo ""; echo "--TURN INTERNET ON--"; sudo nmcli n on; sleep 3; nmcli device status; sleep 3; nmcli device status'

# Linux Internet Status / On / Off:
alias internet='echo ""; echo "--INTERNET CONNECTION STATUS--"; nmcli device status'
alias interoff='echo ""; echo "--TURN INTERNET OFF--"; sudo nmcli n off; sleep 3; nmcli device status; sleep 3; nmcli device status'
alias interon='echo ""; echo "--TURN INTERNET ON--"; sudo nmcli n on; sleep 3; nmcli device status; sleep 3; nmcli device status'
alias internetoff='echo ""; echo "--TURN INTERNET OFF--"; sudo nmcli n off; sleep 3; nmcli device status; sleep 3; nmcli device status'
alias interneton='echo ""; echo "--TURN INTERNET ON--"; sudo nmcli n on; sleep 3; nmcli device status; sleep 3; nmcli device status'

# Norwegian Date & Time:
NOR_TIME=$(date +%d.%m.%Y_%H%M%S)

# Always listing files with colors:
alias ls='ls -A  --color=auto'
alias lsd='ls -Alph  --color=auto'

# Advanced File Listing Options:
alias weird1='ls -d -g *'
alias weird2='ls -r / -lAh -t | head -6'
alias weird3='ls -Alph -d /* | grep -v -e "/proc" -e "/tmp" -e "/lost+found"'
alias weird4='ls -R -t -Alph /* | grep -v -e "/proc" -e "/tmp" -e "/lost+found"'
alias weird5='ls -R -t -Alph /* | grep -v -e "/proc" -e "/tmp" -e "/lost+found" -e "/var/" 2>/dev/null > all-my-files-$NOR_TIME.txt; ls *all-my-fil*'
alias weird6='echo "All files written to file at $NOR_TIME"; ls / * -lAh -t -R > all-my-files-$NOR_TIME.txt; ls *all-my-fil*'
#
alias fivelatest='ls -lAh -t | head -6'
alias fivelatestreverse='lsd -trA | tail -6'
alias tenlatest='ls / -lAh -t -R | head -11' # Need to exclude sys/tmp/proc/lost+found
alias weirdall1='ls / * -lAh -t -R | head -41' # List user content only - not system files like .bashrc
#
alias files='echo -e "\n--OLD STYLE LIST OF FILES--\n"; ls -p | grep -v /'
alias folders='echo -e "\n--OLD STYLE LIST OF FOLDERS--\n"; ls -pA | grep /'
#
alias myfile='life'
alias myfold='echo -e "\n--LIST OF MY FOLDERS - WITH -Alph-d DETAILS--\n"; ls -Alph -d *; echo ""'
alias mycont='echo -e "\n--LIST OF MY FOLDER CONTENT - WITH Alph-g DETAILS--\n"; ls -Alph -g *'
alias mysym='echo -e "\n--LIST OF MY SYMLINKS - WITH Alh-g DETAILS--\n"; ls -Alh -g * | grep /'
#
alias myall='echo -e "\n--ALL FILE AND FOLDER INFO--\n"; myfile; myfold; mycont; mysym'


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
echo -e "\e[1;34m"
echo "AlexData .bashrc -- [$USER @ $HOSTNAME]"
echo ""
echo "PC: ssh admin 8088 rundll32.exe powrprof.dll,SetSuspendState 0,1,0 && powercfg /hibernate off"
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
echo "Users: beuser, becomeuser, beroot, becomeroot"
echo "Internet: internet, interneton, internetoff"
echo ""
echo "Linux: (pipe-commands) | xargs, | yargs, | sort -r, | tac"
echo "Linux: help, info"
echo "Linux: ls, cd, pwd, cp, mv, touch, rm, mkdir, rmdir, tty, uptime"
echo ""
echo "Curl: todo [alexdata-todotxt]"
echo "Notes: note <text>, soon <text>, catnote, catsoon, editnote, editsoon"
echo "Openbox: ob, rob, sob, oob, obd, runopenbox, startopenbox, onlyopenbox, openboxdesktop, useopenbox, chownopenbox"
echo ""
echo "Base64: b64d <base64==>, b64e <text>"
echo ""
echo "Hint: Type 're' or 'repeat' to see all this info again!"
echo ""
echo "Info On Extra D.E:"
echo "sudo chown alexdata:alexdata /openbox-start-cmd.txt |||| chmod a+rwx /openbox-start-cmd.txt"
echo "sudo chown alexdata:alexdata /etc/bash.bashrc |||| sudo chown alexdata:alexdata /home/alexdata/.bashrc"
echo "xinit -- :4 /bin/bash/konsole    # Run one app graphically in TTY"
echo "cat nano kate /boot/AlexOpenBox/openbox-window-manager.md"
echo "Alternative Desktop!"
echo "xterm | arand | nitrogen | feh | pcmanfm --desktop & | "
echo "start -- :4 | xclock | tint2 | picom | /boot/AlexOpenBox/arandr-alex-dualscreens.sh | nitrogen --restore &"
echo "DISPLAY=:4 kate & |||| sudo openvt -c 2 -- your_command_here"
echo ""
echo "Openbox: ob, rob, sob, oob, obd, runopenbox, startopenbox, onlyopenbox, openboxdesktop, useopenbox"
echo ""
echo "Logged on as user:" $USER "on the machine:" $HOSTNAME
USERPATH=$(pwd);#Sets the variable USERPATH to contain command PWD's output!
echo "You are located here right now: $USERPATH"
echo ""
echo -e "\e[0m"
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

function b64d {
echo ${1} | base64 --decode #Decode switch!
}

function b64e {
echo ${1} | base64 #Encode is default!
}

function useopenbox {
echo "Start Minimal Openbox Based Desktop"
read -p "This will CLOSE the PLASMA DESKTOP - Have you saved all your work there? (y/n)" SAVE_ANSWER
read -p "Are you 100% sure you saved all your work in browsers, files and apps? (y/n)" SURE_ANSWER
echo "Good - Then Lets Start The Minimal Openbox Based Desktop"
echo ""
cd /boot/AlexOpenBox/
./openbox-starter.sh    # Run openbox boot script!
}
alias ob='useopenbox'
alias rob='useopenbox'
alias sob='useopenbox'
alias oob='useopenbox'
alias obd='useopenbox'
alias runopenbox='useopenbox'
alias startopenbox='useopenbox'
alias onlyopenbox='useopenbox'
alias openboxdesktop='useopenbox'

function todo {
echo "Remote Curl Alexdata.com To-Do.txt"
curl --ssl https://alexdata.com/notepad/To-Do.txt
}

function chownopenbox {
echo "Set Openbox Config Files Write Access For Normal User"
# Take File Ownership
sudo chown alexdata:alexdata /etc/xdg/openbox/autostart
sudo chown alexdata:alexdata /etc/xdg/openbox/environment
sudo chown alexdata:alexdata /etc/xdg/openbox/menu.xml
sudo chown alexdata:alexdata /etc/xdg/openbox/rc.xml
sudo chown alexdata:alexdata /etc/xdg/tint2/tint2.rc
sudo chown alexdata:alexdata /etc/xdg/picom.conf
# Open files in Kate
kate /etc/xdg/openbox/autostart
kate /etc/xdg/openbox/environment
kate /etc/xdg/openbox/menu.xml
kate /etc/xdg/openbox/rc.xml
kate /etc/xdg/tint2/tint2.rc
kate /etc/xdg/picom.conf
}


# Get biggest packages (ACTUALLY WORKS!)
function bigpacks {
    echo ""
    echo -e "\e[1;35m📦 Top 20 Largest Packages:\e[0m"
    echo ""
    pacman -Qi | awk '
    /^Name/{name=$3}
    /^Installed Size/{
        size=$4
        unit=$5
        if(unit=="GiB") bytes=size*1024*1024*1024
        else if(unit=="MiB") bytes=size*1024*1024
        else if(unit=="KiB") bytes=size*1024
        else if(unit=="B") bytes=size
        else bytes=0
        printf "%015d %.2f %s %s\n", bytes, size, unit, name
    }' | sort -rn | head -20 | awk '{printf "\033[1;36m%-10s\033[0m \033[1;33m%-6s\033[0m %s\n", $2, $3, $4}'
    echo ""re

}

# Shorter version with total size
function bigpacks2 {
    echo ""
    echo -e "\e[1;35m📦 Top 20 Largest Packages:\e[0m"
    echo ""
    pacman -Qi | awk '/^Name/{n=$3} /^Installed Size/{s=$4;u=$5;b=(u=="GiB")?s*1024*1024*1024:(u=="MiB")?s*1024*1024:(u=="KiB")?s*1024:s;printf "%015d %.2f %s %s\n",b,s,u,n}' | sort -rn | head -20 | awk '{printf "\033[1;36m%-8s\033[0m \033[1;33m%-6s\033[0m %s\n",$2,$3,$4}'
    echo ""
}

# Show installed desktop environment
function mydesktop {
    echo ""
    echo -e "\e[1;35m🖥️  Desktop Environment:\e[0m"
    echo ""
    if pacman -Q | grep -q "^plasma-desktop"; then
        echo -e "\e[1;32m✅ KDE Plasma\e[0m"
        ver=$(pacman -Q plasma-desktop | awk '{print $2}')
        echo -e "   Version: \e[1;36m$ver\e[0m"
        count=$(pacman -Q | grep "^plasma-" | wc -l)
        echo -e "   Packages: \e[1;33m$count\e[0m"
    else
        echo -e "\e[1;31m❌ No desktop environment detected\e[0m"
    fi
    echo ""
}

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
# ONLY THIS PART OF IT WORKS: find "/home/alexdata/Desktop/" -type f | sort -nr | head -10 | cut -d: -f2-
# -nr = numeric,reverse || head/tail -10 = 10 newest/oldest || -d: = delimiter || -f2- = possible field 2
# ---------------------------------



# ----------------------------------⚠️
# VARIABLES CURRENTLY NOT IN USE !!!
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
