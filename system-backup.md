# 🐧 BACKING UP YOUR LINUX ARCH SYSTEM 🐧

Here I will present the methods I personally use for backing up my system.
I recommend doing both a local backup, as well as a remote backup.
(the remote backup requires an additional remote ssh, sftp, ftp, web, or file server)

### Once you have a working Linux system running:
- Essential to backup your desktop environment settings.
- Essential to backup you apps settings.
- Essential to backup your personal files.

# Different backup methods will be mentioned and explained here:

## 1. Compressed TAR file with main desktop environment settings:

### Backup all files in home's .config folder - basic backup:
```
tar -czf ~/cachyos-config-$(date +%F).tar.gz ~/.config/
```  

### Save the TAR file to any mounted USB ,EXT4 or NTFS data partition:
```
cp ~/cachyos-config-*.tar.gz /mnt/data/
```  
