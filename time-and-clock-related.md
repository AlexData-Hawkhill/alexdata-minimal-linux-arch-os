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

### OTHER METHODS:
sudo timedatectl set-local-rtc 1 ---------------------- # Fix Windows/Linux time clash!  
sudo cd /etc ------------------------------------------ # 1of3 Change TimeZone. Correct the timezone.  
sudo ln -sf /usr/share/zoneinfo/Europe/Oslo locatime -- # 2of3 Change TimeZone. Correct the timezone.  
sudo date --------------------------------------------- # 3of3 Change TimeZone. Correct the timezone.  
sudo date +%T -s "18:12:59" --------------------------- # Adjust the time manually - if still incorrect!  

<br>

sudo timedatectl set-timezone Europe/Oslo --------------- Set timezone correctly (safer than manual symlink - see below)  
sudo timedatectl set-local-rtc 1 --adjust-system-clock -- Tell Linux: RTC is in local time (like Windows incorrectly uses).  
sudo hwclock --systohc ---------------------------------- Sync system time → hardware clock (in local time).  
timedatectl status -------------------------------------- Show and confirm if current time is correct.  

<br>

sudo cd /etc -------------------------------------------- 1of5 Change TimeZone Procedure.  
sudo ln -sf /usr/share/zoneinfo/Europe/Oslo locatime ---- 2of5 Change TimeZone Procedure.  
sudo date ----------------------------------------------- 3of5 Change TimeZone Procedure.  
ls -la *locat* ------------------------------------------ 4of5 Check what time was set in symlink time file.  
sudo hwclock --systohc ---------------------------------- 5of5 Copy systemclock to hardware clock!  

<br>

date ---------------------------------------------------- Show Date and time.  
sudo date +%T -s "18:12:59" ----------------------------- Set only time and keep current date.  
sudo date -s "2 OCT 2006 18:12:59" ---------------------- Set date and time (as admin).  
sudo date --set="2 OCT 2006 18:12:59" ------------------- Set date and time (as admin).  

<br>

hwclock -r ---------------------------------------------- Show hardware date and time.  
sudo hwclock --show ------------------------------------- Show hardware time (as admin).  
sudo hwclock --show --verbose --------------------------- Show hardware time with verbose info (as admin).  
hwclock --show --utc ------------------------------------ Show time with UTC info included.  
hwclock --systohc --------------------------------------- Copy system clocktime to hardware clock.  
hwclock --hctosys --------------------------------------- Copy hardware clock to systemtime.  

<br>

timedatectl --------------------------------------------- Show date and time detailed info!  
sudo timedatectl set-time YYYY-MM-DD -------------------- Set a new date. Keep the time.  
sudo timedatectl set-time HH:MM:SS ---------------------- Set a new time. Keep the date.  
sudo timedatectl set-time YYYY-MM-DD HH:MM:SS ----------- Set both date and time.  
