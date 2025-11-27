# 🐧 INFO ABOUT BASH AND LINUX'S MANY SHELLS 🐚
_...walking along the linux shore while picking sea shells without bashing them..._

<br>
### Check .bash_profile:
cat ~/.bash_profile  

###  Check .profile:
cat ~/.profile  

###  Check system-wide bashrc:
cat /etc/bash.bashrc  

###  Check /etc/profile:
cat /etc/profile  

###  Check user bashrc (if user or the linux distro has created one):
cat ~/.bashrc  

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
DOS/CMDBashset VAR=valueVAR="value"%VAR%$VARgoto loopsfor/while loops.bat files.sh filesOne versionMany variants!
DOS = Fixed standard - identical in all versions of windows.
Bash = Living language with multiple versions!  

### BASH VERSIONS:  
bash# Check your current bash version:  
bash --version  

### Different versions have different features:  
Bash 3.x - Basic (macOS default)  
Bash 4.x - Arrays, associative arrays  
Bash 5.x - Modern features  

