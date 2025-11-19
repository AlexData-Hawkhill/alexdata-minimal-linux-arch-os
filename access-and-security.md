# TAKING OWNERSHIP OVER FILES FOLDERS AND MOUNTED DRIVES:

### Chown Method:

### Take ownership over folder, and subfolders, as normal (non root) user:
(user=alexdata folder=/boot/info/ and -hR = all subfiles and subfolders)  
```
su -                                  # Become ROOT user.
sudo chown -hR alexdata /boot/info/   # Take ownership over folder as "alexdata" a normal user.
```
