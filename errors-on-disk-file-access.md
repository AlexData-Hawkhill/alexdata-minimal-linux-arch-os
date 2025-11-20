# 🐧 CANNOT ACCESS THE BOOT PARTITON (FAT32 FORMAT) 🐧

### And using Chown on folders or files does not change your access level either...

```bash
[root@arch-alexdata ~]### sudo chown -R alexdata:alexdata /boot/ 
chown: changing ownership of '/boot/TryOut.txt':  
Operation not permitted chown: changing ownership of '/boot/info.txt':  
Operation not permitted chown: changing ownership of '/boot/Linux-Audio-Tips.txt':  
Operation not permitted chown: changing ownership of '/boot/Reinstall-Plasma-Desktop.txt'  
```

So what can be the problem - if it is not file or folder permissions?  
If it is not the user you're using, not file and folder permissions, then it must be the file-system itself!  

Let us check the filesystem for the partition, folder or mount we're struggling with:  
```bash
whoami # Shows your user name - who you are currently logged on as.
```
```bash
id alexdata # Id shows info about the user alexdata in this case.
```
```bash
mount | grep /boot # Should answer with "/boot" file-system "TYPE" in the output.
```
```bash
df -kh # Lets you see if "/boot" is a disk/partition mounted as a folder, of if it is a virtual filesystem. 
```
```bash
cat /etc/fstab | grep boot # Checking the content of the /etc/fstab file.
```

### Example output:  

[alexdata@arch-alexdata ~]$ whoami  
> alexdata  

[alexdata@arch-alexdata ~]$ id alexdata  
> uid=1000(alexdata) gid=1000(alexdata) groups=1000(alexdata),998(wheel)  

[alexdata@arch-alexdata ~]$ ls -la /boot  
> drwxr-xr-x 2 root root   8192 Nov 15 22:12  .  
> drwxr-xr-x 8 root root   4096 Jan  1  1970  ..  

[alexdata@arch-alexdata ~]$ mount | grep /boot  
> /dev/sda1 on /boot type vfat (rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro)  

[alexdata@arch-alexdata ~]$ df -kh  
> Filesystem      Size  Used Avail Use% Mounted on  
> /dev/sda4        29G   23G  4.8G  83% /  
> devtmpfs         16G     0   16G   0% /dev  
> /dev/sda1       3.2G  152M  3.1G   5% /boot  

[alexdata@arch-alexdata ~]$ cat /etc/fstab | grep boot
UUID=4416-1D3E /boot vfat rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro 0 2


So here we have identified a FAT32 filesystem (/boot type vfat) (/dev/sda1 /boot).  
Our user should have access to these files, being part of the wheel group (998), giving our user **sudo** rights.  
So why can we only read, not write, or delete, on this /boot mount?  
Well, it is FAT32 filesystem and thus completely ignore any Unix permissions!  

NOW WE KNOW - ITS A FAT32 FILE-SYSTEM PROBLEM!  
The "/boot" is on the EFI partition (FAT32) which does not support Unix file/folder permissions!  

FAT32 filesystems has no concept of:  
> - User ownership (chown won't work!).    
> - File permissions (chmod won't work!).  
> - Unix attributes.  

# IMMEDIATE FIX - REMOUNT "/boot" WITH DIFFERENT OWNERSHIP:  
Mount partition/disk/folder/filesystem with different ownership options!  
So set your normal day to day user (alexdata) as the owner of this mounted filesystem.  


### 1. Who are you logged on as:
```bash
whoami # Will show your current logged on username.
```

### 2. ID for this user gives us more info we can use:
```bash
id alexdata # Will show additional user info on this particular user.
```

### 3. Who currently stands as owner of files and folders in this mount:
```bash
ls -la /boot # Lists read-write-rights followed by user and group, and even more info. 
```

### 4. Check current mounts filesystem, fmask and dmask:
```bash
mount | grep /boot
```

### 5. Remount with your user as owner:
```bash
sudo umount /boot
```
### 6. Here we set the user with uid and gid 1000 as the owner (the alexdata user's uid and gid).
```bash
sudo mount -o uid=1000,gid=1000,fmask=0077,dmask=0077 /dev/sda1 /boot
```
What the "sudo mount -o" options mean:  
_"mount -o uid=1000,gid=1000,fmask=0077,dmask=0077 /dev/sda1 /boot"._
> **uid=1000** = User ID (alexdata).  
> **gid=1000 **= Group ID (alexdata).  
> **fmask=0077 **= File mask (rw for owner only).  
> **dmask=0077** = Directory mask (rwx for owner only).  

### 7. Test access - did the owner change from root (or some other owner) to your "alexdata" owner:  
```bash
ls -la /boot
```
It should now show alexdata as owner! In some rare cases it may still show root (or different user) as owner.  
And in case it does - use the permanent fix below to fix that!  


## PERMANENT FIX - UPDATE /etc/fstab:  

### 1. Again! Find your user/group ID:  
```bash
id alexdata
```
> Shows: uid=1000(alexdata) gid=1000(alexdata) in my case/example.  

### 2. Edit fstab:  
```bash
sudo _nano_ /etc/fstab
```

### 3. In the the "/etc/fstab" file - Find the "/boot" line, change from:  
> **UUID=4416-1D3E  /boot  vfat  defaults  0 2**  

### 4. Change the "/etc/fstab" to:  
> **UUID=4416-1D3E  /boot  vfat  rw,relatime,fmask=0077,dmask=0077,uid=1000,gid=1000  0 2**  
This means to mount it as owned by user 1000 (alexdata) and group 1000 (alexdata) with 0077 rights.  

### 5. Save & exit _nano_ (Ctrl+O,or F3, + Enter, + Ctrl+X).
Save the "fstab" file in the "/etc/" folder with _nano_, and save it using F3, exit _nano_ using CTRL+X.  

### 6. Test the fstab file you just changed - by reloading it:
```bash
sudo umount /boot
```
```bash
sudo mount -a
```
Or... If "**systemd**" says it is "_using the old version of fstab_" - then use this command instead:
```bash
systemctl daemon-reload
```
This should now mount without any further issues!


### 7. Verify ownership:
```bash
ls -la /boot/  
```
Should now show alexdata as owner and group (not: root root)!  

## IF THERE IS STILL AN ISSUE WITH MOUNTING AS YOUR USER:

### Get your UID and GID:
```bash
id alexdata
```

### Output should be:
> uid=1000(alexdata) gid=1000(alexdata) groups=1000(alexdata),998(wheel)...
If your UID is not 1000, use your actual UID number in the mount options above!

YOUR COMPLETE /etc/fstab SHOULD LOOK LIKE:  
> ### /boot (EFI partition with ownership)
> UUID=4416-1D3E  /boot  vfat  rw,relatime,fmask=0077,dmask=0077,uid=1000,gid=1000,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro  0 2
>
> ### / (root partition)
> UUID=<your-root-uuid>  /  ext4  rw,relatime  0 1

ALTERNATIVE - LESS RESTRICTIVE (If you want group access too):  
In fstab, use:  
> UUID=4416-1D3E  /boot  vfat  rw,relatime,fmask=0022,dmask=0022,uid=1000,gid=1000  0 2  

This gives: 
> - Owner (alexdata): full access.  
> - Group: read access.  
> - Others: read access.

## And remember FAT32 limitations:  
> - No Unix permissions  
> - No ownership metadata  
> - No symlinks  
> - No hard links  
> - No executable bit  
### Solution: Set ownership at mount time, not per-file or folder! 🔥
