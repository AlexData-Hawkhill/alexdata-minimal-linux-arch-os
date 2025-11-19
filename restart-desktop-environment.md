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
sudo localectl set-locale LANG=en_US.UTF-8
```
```
echo 'export LANG=en_US.UTF-8' >> .bashrc
```
```
# MAY ALSO TRY:
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```

Check locale to be correct as what we set it to be "en_US.UTF-8" during install:
```
locale -a
```
Expected output:
> en_US.utf8 
> POSIX

If output is different - then edit this file:
```
nano /etc/locale.conf
```
Expected file content:
> LANG=en_US.UTF-8

Logout from bash or any other graphical desktop you're in at this point.  
```
loginctl terminate-user $USER
```
```
# IF IT IS ANOTHER USERS SESSION THAT IS THE PROBLEM:
loginctl list-sessions
loginctl terminate-session SESSION_ID
```
### Restart bash itself:
```
source ~/.bashrc
```

### Kill of the desktop environment itself:
### Login as root and run this (write "exit" to log out as that user)
```
killall plasmashell    # Allow it time to stop properly!
```

### If you see more than one plasma environment running - kill the all with this:
```
killall -9 plasmashell    # Force it to close instantly! If frozen!
```
And check that all instances of "plasmashell" are gone from this listing:
```
ps aux | grep plasmashell
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
export XDG_SESSION_TYPE=x11
```
```
plasmashell &             # Starts KDE-Plasma desktop environment.
```
```
#kwin_x11 &               # Alternative to start if kde plasma wont start.
```

### If all else fails:
```
sudo reboot        # Restart the system! This may also solve desktop problems!
```
```
sudo shutdown mow    # Turn off the machine! This may also solve desktop problems!
```
