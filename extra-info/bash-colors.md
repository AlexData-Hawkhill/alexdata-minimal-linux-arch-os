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
