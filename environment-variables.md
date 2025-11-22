# 🐧 ENVIRONMENT VARIABLES - IN LINUX OS 🐧

### System-Wide Variables:  
Main system environment file:  
```/etc/environment```

### Example contents:  
```PATH=/usr/local/bin:/usr/bin:/bin```  

### System-wide profile (runs for all users):
```/etc/profile```  
```/etc/profile.d/*.sh```  

### Example in /etc/profile.d/hostname.sh:
```export HOSTNAME=$(hostname)```  

User-Specific Variables - Your personal files (in order of execution):  
```~/.bash_profile   # Login shell (runs first)```  
```~/.profile        # Alternative to bash_profile```  
```~/.bashrc         # Non-login shell (the "add alias and functions" file!)```  

### Where Specific Variables Come From:  
$PATH - Built from multiple sources:  
```/etc/environment          # System PATH```  
```/etc/profile              # Adds to PATH```  
```~/.bash_profile           # User additions```  
```~/.bashrc                 # More user additions```  

### $USER - Set by login process:
Comes from /etc/passwd when you log in  
Set by PAM (Pluggable Authentication Modules)  

### $HOSTNAME - Set by system:
```/etc/hostname             # Your machine name```  
Also:  
```hostnamectl set-hostname <name>```  

### $HOME - Set by login:
```Comes from /etc/passwd (your home directory)```  

# SEE ALL AVAILABLE ENVIRONMENT VARIABLES:

### All exported variables (available to child processes):  
```env    #env | sort```  
or:  
```printenv```  

### All variables (including shell-only):
```set```  

### Declare with types:
```declare -p```  

### Just the names (no values):
```compgen -v```  

### Fun Exploration Commands:
See all exported variables sorted:  
```env | sort```  

### Count your variables:
```env | wc -l```  

### Search for specific patterns:
```env | grep -i path```  
```env | grep -i user```  

### See variables with their types:
```declare -p | less    #if you have the "less" command avail```  

### See only functions:
```declare -F```  

### See functions with their code:
```declare -f```  

# COMMON USEFUL LINUX VARIABLES:  

### User info:
```$USER           # Your username (alexdata)```  
```$UID            # Your user ID (1000)```  
```$HOME           # Your home directory (/home/alexdata)```  
```$SHELL          # Your shell (/bin/bash)```  

### System info:  
```$HOSTNAME       # Machine name (arch-alexdata)```  
```$HOSTTYPE       # CPU type (x86_64)```  
```$OSTYPE         # OS type (linux-gnu)```  

### Paths:  
```$PATH           # Command search path```  
```$PWD            # Current directory```  
```$OLDPWD         # Previous directory (cd -)```  

### Shell behavior:  
```$PS1            # Prompt string```  
```$TERM           # Terminal type```  
```$EDITOR         # Default editor (nano, vim, etc.)```  

### Special:
```$?              # Exit status of last command (0 = success)```  
```$$              # Current shell PID```  
```$!              # Last background process PID```  
```$0              # Script/shell name```  
```$1, $2, $3...   # Script arguments```  

Paths are usefull in scripting, in bash directly, and in Python as well as other code languages.  
Also when it comes to servers, and when working with virtual environments, as well as apps like FFMPEG.  

### WHERE TO PUT PERMANENT PATH ADDITIONS:
Add to ~/.bashrc:  
```export PATH="$PATH:/your/custom/path"```  

### Example:
```export PATH="$PATH:$HOME/bin:$HOME/.local/bin"```  

### Or in ~/.bash_profile (login shell):
```PATH="$PATH:$HOME/scripts"```  
```export PATH```  

### View your complete Linux environment:
Save everything for reference:  
```env > ~/my-environment.txt```  
```set > ~/my-shell-variables.txt```  
```declare > ~/my-declarations.txt```  

### View all environment variables:
```cat ~/my-environment.txt```  

