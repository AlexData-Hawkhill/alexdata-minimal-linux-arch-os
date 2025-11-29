# COLORS IN YOUR BASH / TERMINAL

## Add this to your home user ~/.bashrc (or the global bashrc):

### Basic prompt with time (no color):
PS1='\t \u@\h:\w\$ '
Result: 03:30:45 alexdata@hostname:~/path$

### Colorful prompt with time (cyan clock):
PS1='\[\e[38;5;39m\]\t\[\e[0m\] \[\e[38;5;46m\]\u\[\e[0m\]@\[\e[38;5;208m\]\h\[\e[0m\]:\[\e[38;5;51m\]\w\[\e[0m\]\$ '
```
Result: 03:30:45 alexdata@hostname:~/path$
        ^cyan    ^green   ^orange    ^cyan
```

# My recommended style (dark green clock) (Two-line prompt with arrow!):
PS1='\[\e[1;36m\]\t\[\e[0m\] \[\e[1;32m\]\u\[\e[0m\]@\[\e[1;33m\]\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\n\[\e[1;35m\]→\[\e[0m\] '
```
Result: 
03:30:45 alexdata@hostname:~/path
  ^cyan    ^green   ^gold     ^cyan
→ 
^purple
```

# My recommended style (purple clock) (Two-line prompt with arrow!):
PS1='\[\e[38;5;51m\]\t\[\e[0m\] \[\e[1;32m\]\u\[\e[0m\]@\[\e[1;33m\]\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\n\[\e[1;35m\]→\[\e[0m\] '
```
Result: 
03:35:55 alexdata@hostname:~/path
^purple  ^green   ^gold      ^cyan
→ 
^purple
```
