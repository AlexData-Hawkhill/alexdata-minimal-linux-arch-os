# 💻👨🏻‍💻 COLORS IN YOUR BASH / TERMINAL 👨🏻‍💻💻
If you want to just test color in the bash prompt, then copy one of the **PS1** lines below,  
and paste that into your Terminal/Konsole's bash prompt, and then press ENTER.  
This change will be present until you close your terminal/konsole and then it will auto reset.  

If you want the colour to be permanent, then add this line to your (home) **~/.bashrc** (or the global **/etc/bash.bashrc**).  
See my [example .bashrc](/.bashrc) file for how to do this - and many other cool additions that simplify things!

![bash colours](/images/bash-colours.webp)

<br>

### My recommended style (purple clock) (Two-line prompt with arrow!):
```bash
PS1='\[\e[38;5;51m\]\t\[\e[0m\] \[\e[1;32m\]\u\[\e[0m\]@\[\e[1;33m\]\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\n\[\e[1;35m\]→\[\e[0m\] '
```
```
Result: 
03:35:55 alexdata@hostname:~/path
^purple  ^green   ^gold      ^cyan
→ 
^purple
```

<br>

### My recommended style (dark green clock) (Two-line prompt with arrow!):
```bash
PS1='\[\e[1;36m\]\t\[\e[0m\] \[\e[1;32m\]\u\[\e[0m\]@\[\e[1;33m\]\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\n\[\e[1;35m\]→\[\e[0m\] '
```
```
Result: 
03:30:45 alexdata@hostname:~/path
  ^cyan    ^green   ^gold     ^cyan
→ 
^purple
```

<br>

### Colorful prompt with time (cyan clock):
```bash
PS1='\[\e[38;5;39m\]\t\[\e[0m\] \[\e[38;5;46m\]\u\[\e[0m\]@\[\e[38;5;208m\]\h\[\e[0m\]:\[\e[38;5;51m\]\w\[\e[0m\]\$ '
```
```
Result: 03:30:45 alexdata@hostname:~/path$
        ^cyan    ^green   ^orange    ^cyan
```

<br>

### Basic prompt with time (no color):
```bash
PS1='\t \u@\h:\w\$ '
```
```
Result: 03:30:45 alexdata@hostname:~/path$
```

<br>

### Normal prompt (no time) (no color):
```bash
PS1='\t \u@\h:\w\$ '
```
```
Result: alexdata@hostname:~/path$
```

<br>

### VALUES USED - EXPLAINED:
\t  = Time (HH:MM:SS)  
\u  = Username  
\h  = Hostname    
\w  = Current directory (full path)  
\W  = Current directory (basename only)  
\$  = $ for user, # for root  
\n  = Newline  

### Colors:
\[\e[1;36m\]  = Bright cyan  
\[\e[1;32m\]  = Bright green  
\[\e[1;33m\]  = Bright yellow  
\[\e[1;34m\]  = Bright blue    
\[\e[1;35m\]  = Bright magenta  
\[\e[0m\]     = Reset color  

<br>

### THE COMPLETE COLOR PALETTE:  
Also see example script: [show-colors.sh](/scripts/show-colors.sh)  or my [.bashrc](/.bashrc)  

═══════════════════════════════════════════════  
**STANDARD COLORS (30-37)**  
═══════════════════════════════════════════════  
echo -e "\e[30mBlack\e[0m"  
echo -e "\e[31mRed\e[0m"  
echo -e "\e[32mGreen\e[0m"  
echo -e "\e[33mYellow\e[0m"  
echo -e "\e[34mBlue\e[0m"  
echo -e "\e[35mMagenta\e[0m"  
echo -e "\e[36mCyan\e[0m"  
echo -e "\e[37mWhite\e[0m"  

═══════════════════════════════════════════════  
**BRIGHT COLORS (90-97) - High Intensity**  
═══════════════════════════════════════════════  
echo -e "\e[90mBright Black (Gray)\e[0m"  
echo -e "\e[91mBright Red\e[0m"  
echo -e "\e[92mBright Green\e[0m"  
echo -e "\e[93mBright Yellow\e[0m"  
echo -e "\e[94mBright Blue\e[0m"  
echo -e "\e[95mBright Magenta\e[0m"  
echo -e "\e[96mBright Cyan\e[0m"  
echo -e "\e[97mBright White\e[0m"  

═══════════════════════════════════════════════  
**BOLD COLORS (1;3X) - Your favorites!**  
═══════════════════════════════════════════════  
echo -e "\e[1;30mBold Black\e[0m"  
echo -e "\e[1;31mBold Red\e[0m"  
echo -e "\e[1;32mBold Green\e[0m"  
echo -e "\e[1;33mBold Yellow/Gold\e[0m"  
echo -e "\e[1;34mBold Blue\e[0m"  
echo -e "\e[1;35mBold Magenta/Purple\e[0m"  
echo -e "\e[1;36mBold Cyan\e[0m"  
echo -e "\e[1;37mBold White\e[0m"  

═══════════════════════════════════════════════  
**256-COLOR MODE (38;5;X) - ADVANCED!**  
═══════════════════════════════════════════════  
echo -e "\e[38;5;196mRed (256)\e[0m"  
echo -e "\e[38;5;202mOrange\e[0m"  
echo -e "\e[38;5;226mYellow\e[0m"  
echo -e "\e[38;5;118mLime Green\e[0m"  
echo -e "\e[38;5;46mBright Green\e[0m"  
echo -e "\e[38;5;51mCyan/Sky Blue\e[0m"  
echo -e "\e[38;5;21mDark Blue\e[0m"  
echo -e "\e[38;5;27mRoyal Blue\e[0m"  
echo -e "\e[38;5;33mDodger Blue\e[0m"  
echo -e "\e[38;5;39mDeep Sky Blue\e[0m"  
echo -e "\e[38;5;63mPurple\e[0m"  
echo -e "\e[38;5;201mMagenta\e[0m"  
echo -e "\e[38;5;208mDark Orange\e[0m"  
echo -e "\e[38;5;214mGold\e[0m"  

═══════════════════════════════════════════════  
**BACKGROUND COLORS (40-47)**  
═══════════════════════════════════════════════  
echo -e "\e[41mRed Background\e[0m"  
echo -e "\e[42mGreen Background\e[0m"  
echo -e "\e[44mBlue Background\e[0m"  
echo -e "\e[43mYellow Background\e[0m"  

═══════════════════════════════════════════════  
**COMBINATIONS!**  
═══════════════════════════════════════════════  
echo -e "\e[1;31m\e[44mBold Red on Blue\e[0m"  
echo -e "\e[1;33m\e[40mGold on Black\e[0m"  

<br>

### Write to screen "ECHO WITH COLORS":
THE SECRET: -e FLAG MUST BE USED! 🔑  
Examples:  
echo -e "\e[1;31mRed text\e[0m"  
echo -e "\e[1;32mGreen text\e[0m"  
echo -e "\e[1;34mBlue text\e[0m"  
echo -e "\e[1;35mMagenta text\e[0m"  

### Multiple colors in one line:  
echo -e "\e[1;31mRed\e[0m and \e[1;34mBlue\e[0m and \e[1;32mGreen\e[0m"  

### Without -e flag, you will just get literal code output as text:  
echo "\e[1;31mRed\e[0m"  
Output: \e[1;31mRed\e[0m (_Literal text output!_)  

<br>

### FANCY ADVANCED TWO-LINE PROMPT's:
AlexData special edition:
```bash
PS1='\n\[\e[1;36m\]╭─[\[\e[1;32m\]\t\[\e[1;36m\]][\[\e[1;33m\]\u\[\e[1;36m\]][\[\e[1;35m\]\h\[\e[1;36m\]][\[\e[1;34m\]\w\[\e[1;36m\]]\n╰─\
[\e[1;31m\]→\[\e[0m\] '
```
```
Result:
╭─[03:30:45][alexdata][hostname][~/path]
╰─→ 
```

### The git branch looks (bonus!):
parse_git_branch() {  
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'  
}  

```bash
PS1='\n\[\e[1;36m\]╭─[\[\e[1;32m\]\t\[\e[1;36m\]][\[\e[1;33m\]\u\[\e[1;36m\]][\[\e[1;34m\]\w\[\e[1;36m\]]\[\e[1;35m\]$(parse_git_branch)\[\e[0m\]\n\[\e[1;36m\]╰─\[\e[1;31m\]→\[\e[0m\] '
```
```
Result:
╭─[03:30:45][alexdata][~/my-repo](main)
╰─→
```







