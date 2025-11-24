# FILE SYSTEM TOOLS - NICE TO KNOW ABOUT

### 1. What filesystem is your drive or partition (or virtual filesystem in container file): 
```bash
sudo blkid /dev/sda2
```

### 2. Try to detect the filesystem with this command - gives lots of detail - harder to read:
```bash
sudo file -s /dev/sda2
```

### 3. Detailed info - easy to read:
```bash
lsblk -f | grep sda2
```

### 4. Check mounted filesystems:
```bash
mount | grep SHARED-LINUX
```

### 5. Check permissions on the mount point:
```bash
ls -la /run/media/$USER/
```

### 6. Or check where the drive, partition or filesystem is mounted.  
```bash
lsblk -f          # Easy to read!
```
```bash
df -kh            # Easy to read!
```
```bash
sudo parted -l    # Easy to read!
```
```bash
fdisk -l           # Harder to read!
```
```bash
mount              # Harder to read!
