# 🐧🏖️ INFO ABOUT BASH AND LINUX'S MANY SHELLS 🐚🐧
_...walking along the linux shore - while sourcing sea shells - without bashing any of them apart..._

<br>

# USAGE IN SCRIPTING:

In any script you create and run, you should specify either:
That it uses bash commands:  
#!/bin/bash  

Or if it uses strict POSIX (unix)(the original):  
#!/bin/sh  

<br>


# USAGE IN YOUR TERMINAL OF CHOICE:
In Linux you have options to add "permanent" commands to your unix/posix/ when it runs bash.  
So to do that - the commands need to be added to one for the following files:

<br>
###  Check user .bashrc (if you or the linux distro has created one):
cat ~/.bashrc    # The recommended palce to put such commands!  

###  Check system-wide bashrc:
cat /etc/bash.bashrc    # If you know linux well, as a sys admin, then maybe here too!  

### Check .bash_profile:
cat ~/.bash_profile    # Another possible place.  

###  Check .profile:
cat ~/.profile    # Another possible place.  

###  Check /etc/profile:
cat /etc/profile    # Another possible place.  

 

<br>

# Debug functions you write in a .bashrc file:

###  Method 1 (verbose output):
bash -xc 'source ~/.bashrc && new_files 2 /'  

PS: If you run (bash function is: new_files 2 /):  
bashbash -x new_files 2 /  

You're starting a **NEW bash process** that:  
1. Doesn't have your functions loaded.  
2. Thinks "new_files" is a file to execute.  

**Remember: Functions only exist in the shell where they're defined!**  
(So if your shell did not run your .bashrc then it will not know of those commands)  


###  Method 2 (in current shell):  
set -x              # Enable debug mode in current shell  
new_files 2 /       # Run your function (my function takes two inputs "2" and "/")  
set +x              # Disable debug mode in current shell  

### STILL BUGS - TRY WITH NO BASH PROFILE LOADED:
Start a clean bash with NO profile loaded:  
bash --noprofile --norc     # This will also reveal the version of your bash - see prompt change!

Now source just your own .bashrc file:  
source ~/.bashrc  

Does it still error before sourcing, after souring? Then that pinpoints the error location!

<br>

# SEARCH FOR SPECIFIC WORDS IN SPECIFIC .bashrc FILES
In this example we search for "Desktop" and "/bin$" but you can search for anything!  
Also we are searching several files at once:  
~/.bashrc  
~/.bash_profile  
~/.profile  
/etc/profile  
/etc/bash.bashrc  

**Search:**  
grep -n "Desktop" ~/.bashrc ~/.bash_profile ~/.profile /etc/profile /etc/bash.bashrc 2>/dev/null  
grep -n "/bin$" ~/.bashrc ~/.bash_profile ~/.profile /etc/profile /etc/bash.bashrc 2>/dev/null  

for file in ~/.bash_profile ~/.profile /etc/profile /etc/bash.bashrc; do echo "=== $file ==="; grep -n "Desktop\|^/bin$" "$file" 2>/dev/null || echo "Not found or doesn't exist"; done  

**TIP:**   
Rename potentially broken files and look for the error again - rename back when done:  
mv ~/.bash_profile ~/.bash_profile.backup 2>/dev/null  
mv ~/.profile ~/.profile.backup 2>/dev/null  

<br>

## **UNIX SHELLS EXPLAINED:**

### **The Hierarchy:**
```
UNIX Kernel
    ↓
Shell (command interpreter)
    ↓
Terminal Emulator (visual wrapper)
```
### SHELLS (The Language Interpreters):
Think of shells like different CODE LANGUAGES talking to the UNIX kernel:  

### sh (Bourne Shell) - "Latin"  
The original (1979)  
Simple, POSIX-compliant  
Every Unix has it  
Like: DOS is to Windows  

### bash (Bourne Again Shell) - "English"  
Most popular (1989)  
Superset of sh + extras  
Default on most Linux OS (distro's)   
_(This is the one you're using as default on Arch Linux)_

### zsh (Z Shell) - "French"  
Modern, feature-rich (1990)  
Better autocomplete  
Themes and configs (Oh My Zsh!)  
macOS default shell  

### fish (Friendly Interactive Shell) - "Spanish"  
User-friendly (2005)  
Auto-suggestions  
Syntax highlighting  
NOT fully POSIX-compliant language!  

### ksh (Korn Shell) - "German"  
Enterprise/corporate (1983)  
Fast scripting  
Used in banking/telecom  

### csh/tcsh (C Shell) - "Italian"  
C-like syntax (1978)  
Interactive features  
Mostly historical  

### KEY DIFFERENCES WINDOWS VS LINUX:  
DOS vs Bash:  
DOS ---- BASH  
set VAR=value ---- VAR="value"  
%VAR% ---- $VAR   
goto loops ---- for/while loops.  
bat files ----.sh files  
One version ---- Many variants!  
DOS = Fixed standard - identical in all versions of windows.  
Bash = Living language with multiple versions!   

### BASH VERSIONS:  
bash# Check your current bash version:  
bash --version  

### Different versions have different features:  
Bash 3.x - Basic (macOS default)  
Bash 4.x - Arrays, associative arrays  
Bash 5.x - Modern features  

<br>

# **TERMINAL EMULATORS **
**(The Window 🪟 Where You Talk To The Kernel From)**   

These are just **visual wrappers** - they don't change the language (sh, bash, fish, m.m)!  
```
konsole   - KDE's terminal (what you use!)
xterm     - Original X11 terminal
gnome-terminal - GNOME's terminal
alacritty - GPU-accelerated
kitty     - Modern, feature-rich (Hello Kitty!)
```

**Think of it like:**  
- **Shell** = Python interpreter  
- **Terminal** = VS Code, PyCharm, Notepad++  
  
**Same language, different editor!**  

**Meaning - Linux IS Unix!**
```
Unix (1969) → Philosophy & design
    ↓
Linux (1991) → Unix-like kernel
    ↓
Bash → Unix shell language
    ↓
Konsole → Visual wrapper (Terminal Emulator)

Related Distro's Info:
Zorin OS        → bash 5.x ✅  
Elementary OS   → bash 5.x ✅  
Alpine OS       → ash (busybox sh) ✅  
Arch OS         → bash 5.x ✅ 
```

**You're basically speaking Unix through bash language in a konsole "Terminal" window!** 🐧⚡

### **THE ANALOGY - IF WE COMPARE IT TO OTHER THINGS:**
```
Shell     = Programming language.
Terminal  = Text editor/IDE.
Kernel    = Operating system.

OR...

Bash in Konsole = Python in VS Code.
Fish in Kitty   = JavaScript in Sublime.
Zsh in Alacritty = Ruby in Vim.
```


<br>


