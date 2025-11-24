# 🐧 MAKE ANY MOUNT PERSISTENT ON YOUR SYSTEM 🐧

### Add the mount to "/etc/fstab" file:
Edit fstab file (as root):   
```bash
nano /etc/fstab    # You can also use Kate, or Gpedit!
```
Add this line to "fstab file:
> UUID=5476D02976D00E1C  /run/media/alexdata/SHARED-LINUX  ntfs-3g  defaults,uid=1000,gid=1000,umask=0022  0  0


🧠⚠️ **Alex -- Explain how this line above was found (see: polkit, both disk drive access, copy code here)!**


> UUID        = The drive or partition (or virtual filesystems) ID.  
> /run/media/ = The path to the drive or partition you want to mount.
> ntfs-3g     = Mount it as NTFS ib this care (I am dual booting windows and linux).
> UID and GID = User ID and Group ID (same as for your normal user; 1000)
> umask + 0 0 = This is just needs to be written as seen here! Same for many mounts!

### Save and test your persistent mount:  
```bash
systemctl daemon-reload
```
```bash
mount -a    # Mounts all mounts defined in the fstab file!
```

### AUTO-MOUNT WITH PROPER PERMISSIONS:
Add to fstab with your user ownership:  
> UUID=5476D02976D00E1C  /run/media/alexdata/SHARED-LINUX  ntfs-3g  rw,uid=1000,gid=1000,umask=0022,nofail  0  0  

This will cause this disk to:  
- Auto-mount on boot.  
- Owned by "alexdata" (uid=1000) as in your "normal user"!  
- If the drive is not present, booting Arch Linux continues (nofail fixes that).  
