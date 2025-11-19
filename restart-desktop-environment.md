# 🐧 RESTART DESKTOP ENVIRONMENT 🐧

### USE "TTY" THE VIRTUAL BASH SESSIONS AVAILABLE
- Log in as "root" to stop and shut down unresponsive desktop environments.  
- Log in as "a normal user" to restart any GRAPHICAL desktop environment.   
  (PS: root cannot start visual graphical environements).  
- CTRL + ALT + F1-F6 (change between virtual bash shells.  
- CTRL + ALT + F7-F8 (change between visual desktop environments loaded).  



## Check what is already running:
### Login as "a normal user" and run this (write "exit" to log out as that user)
```
ps aux | grep plasmashell
```
```
ps aux | grep plasma
```
```
ps aux | grep kwin
```


### Reset the language - so that everything loads correctly upon restart
```
sudo localecrl set-locale LANG=en_US.UTF-8
```
```
echo 'export LANG=en_US.UTF-8' >> .bashrc
```

### Restart bash itself:
```
source ~/.bashrc
```

### Kill of the desktop environment itself:
### Login as root and run this (write "exit" to log out as that user)
```
killall plasmashell && plasmashell &
```

### Restart the login manager (to force load of desktop environment):
### Login as normal user and run this (write exit to log out as that user)
```
sudo systemctl restart sddm
```

### Check and restart desktop environment in an alternative way:  

### Check whats running:
```
echo $XDG_SESSION_TYPE
```

### Restart Desktop Environment:
```
export DISPLAY=0
```
```
export XDG_SESSION_TPE=x11
```
```
plasmashell &             # Starts KDE-Plasma desktop environment.
```
```
#kwin_x11 &               # Alternative to start if kde plasma wont start.
```
