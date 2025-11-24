# 🐧 Setting or correcting the clock manually/automatic 🐧

### 1. Check all details about current time status:
```bash
timedatectl status
```

### 2. Check if timesyncd is running - needed for correct clocks:
```bash
systemctl status systemd-timesyncd
```

### 3. Try setting remote time server NTP via command line:
```bash
sudo timedatectl set-ntp true    # Sets automatic clock synced with remote time server!
```

### 4. Check your current timezone:
```bash
timedatectl list-timezones | grep -i oslo    # Lists the time-zone you're currently using!
```
### or try this if the above lists nothing:
```bash
timedatectl list-timezones | grep -i europe    # Often list all time-zone related capitals!
```

### 5. Set timezone (if what you see listed is wrong):
```bash
sudo timedatectl set-timezone Europe/Oslo
```

### 6. Check polkit (Policy) rules for time:
```bash
pkaction | grep time
```

### 7. Manual time set test - set time and date manually:
```bash
sudo timedatectl set-time "2025-11-24 21:30:00" # Format:year-month-day 24:hour:clock
```
