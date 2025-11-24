### 1. What filesystem is your drive or partition (or virtual filesystem in container file): 
sudo blkid /dev/sda2

### 2. Try to detect the filesystem with this command - gives lots of detail - harder to read:
sudo file -s /dev/sda2

### 3. Detailed info - easy to read:
lsblk -f | grep sda2
