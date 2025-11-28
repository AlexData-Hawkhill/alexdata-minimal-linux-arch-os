# 🐧 AlexData-Minimal-Linux-Arch-OS [🐧](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)

Current Progress For This "_Edit Git Manual For Others - While We Learn Linux Ourselves_" Project:
- [x] Install instructions for Minimal Arch OS (_first edition - still needs some editing_) !!  
      [Link: Install Linux Arch OS - minimal install](/arch-minimal-install.md)  
      
- [x] How to navigate the new Linux world - new commands - new programs - new logic...  
      [Link: using bash-and-shells](/bash-and-shells.md)  
      [Started: become admin in linux with su and sudo](/admin-in-linux--su--sudo.md)  
      [Started: using filesystem-tools](/filesystem-tools.md)  

- [x] Installing software (Both Linux and Windows software)...  
      [Link: Firewall for Linux Arch (must have!)](/firewall-for-arch.md)  
      [Link: Recommended Linux Apps](/recommended-apps.md)  
      [Link: Python on Linux](/python-on-linux.md)  
      [Coming: Wine Installation](/arch-minimal-install.md)  

- [ ] Checks to perform after first boot (firewall, mounts, app-packages, update, m.m) - indirectly started...  
      [Link: Firewall for Linux Arch (must have!)](/firewall-for-arch.md)  
      [Coming: Open Snitch Firewall Gui](/firewall-for-arch.md)  

- [ ] System backup - started... (_many scripts written - none uploaded yet_)  
      [Link: system-backup.md](/system-backup.md)  
      
- [ ] Error handling when installing ARCH OS from USB or DVD...  
      [Coming: soon](/arch-minimal-install.md)  

- [x] Error handling after ARCH OS has been installed...  
      [Started: anything time-and-clock-related](/time-and-clock-related.md)  
      [Started: anything anguage-locale related](/language-locale.md)  
      [Started: file-and-folder-access](/file-and-folder-access.md)  
      [Started: errors-on-disk-file-access](/errors-on-disk-file-access.md)  
      
- [x] Error handling unexpected errors when OS is proper up and running...  
      [Link: polkit security issues](/polkit-security-issues.md)  
      [Link: python and linux](/python-and-linux.md)  
      [Link: language and locale](/language-locale.md)  

- [x] How To Restart Desktop Environment (No reboot) - near complete!  
      [Link: restart-desktop-environment](/restart-desktop-environment.md)  
      
- [x] Linux Environment variables (for coders) - near complete!  
      [Link: environment-variables](/environment-variables.md)  

- [ ] Other things I learn eventually...  
      [Coming: soon](/arch-minimal-install.md)  
      
- [x] A copy of my .bashrc file - place this in your home folder for more effective bash use.   
      (_PS: _Rename any old .bashrc file present - preserve it, don't delete it_)  
      [Link: My current live .bashrc file](/.bashrc)  

- [x] A copy of my other useful scripts - see my scripts folder.  
      [Link: Script - set-mixed-locale-nor-eng](/scripts/set-mixed-locale-no-en.sh)  
      [Link: Script - auto-start-python-venv](/scripts/auto-start-python-venv.sh)  

<br>

## My personal instructions for how to install **🐧 Minimal Linux Arch OS 🐧**    
...but first... a tiny story on how this guide came to life!
<br>

**A Personal Opinion and a short story for why i created this guide:**  
I come from a long line of Windows editions, and after Windows 11, and all it's uncomfortable security changes!!  
The time had finally come - to revisit the **Linux world!** And I was pleasurely surprised! Linux surpasses windows on many things!  
I tested a few Distro's (think windows versions like xp, win7, win8, win10, and well, the newest one prompting me to leave Windows)  

**Here are a few Linux distro's that I can easily recommend for previous Windows users:**  
- **CachyOS** (Very good - and it's based on arch - you got everything you need with this one, right out of the box).  
- **ZorinOS** (Even more similar to Windows than CachyOS, but drivers are older than 5-series nvidia!).  
- **Arch OS** (What i base this minimal Arch install on - Very similar to CacchyOS - but with less additional programs/apps).  
I have tested way more distro's than this, and who knows, I may end up writing more about those too! (if i do, a link will be placed right here).  

The machine I am using for Linux has a MSI motherboard, i9 CPU, 32gb ram, RTX-5070, 12gb vram, 1tb M2.ssd + S-ata HDD.  
In this scenario this machine is setup as a dual-boot with windows being installed on the M2.ssd (_as fallback - for a little while longer_).  
While Linux is installed to the S-ata HDD (its partition 1[boot] and 4[root], partition 2 and 3 holds data. (_Soon Linux will get the SSD!_).  

### My goals for this minimal Linux Arch OS were these:  
- A minimally bloated OS (unlike what Windows is currently doing).  
- A more secure OS, with no telemetry, no windows spying software, no dreaded windows recall (AI that screenshots your screen each 3 seconds).  
- No built in AI Agent, aka, Copilot. (same used for the unsafe Recall "feature").  
- No fake TPM chip security, Safe Boot, Fast boot, and other weird things that stop the user from controlling its own machine.  
- No forced updates that keeps changing the system that works perfectly.  
- No antivirus that force updates your PC if you turn off Windows Updates.  
- No need for anti-telemetry apps (anti ms spyware - if you will).  
- Not having 200 processes running 15% cpu, when the machine sits still/idle and should do "nothing".  
- Not having 1-300 connectings to random servers, when no internet program (browser, ftp, vpn, m.m) is running.  
- And then you can list all else a quick "what is wrong with windows 11" youtube or google seach mgiht tell you even more about!  

### I also had a few more goals:  
- Beinag able to run Python, AI, LLM, Stable Diffusion, ComfyUI the same way i now do on Windows.  
- Being able to run FL STUDIO (music production) with all its plugins (additional vst packages)!  
- Being able to run Notepad++ (that i use for codimg - and note taking).  
- Potenitally being able to run other Windows apps that I may not find an equal for in the Linux world of apps and packages!  

I am providing my own personal guides - all tested by myself!  
Also provide a few scripts to help do (or redo) certain things!  
And a lot of ducuments explaining how to do things the linux way - as well as how to fix things that break, or behave unexpected!  
I'll do my best to cover anything I've experienced during this minimal install of Arch - good or bad!  

If you see something vital missing, then let me know, and do keep in mind i came from Windows to Linux during the month of Nov 2025.  
So, there might be "_a few things_" I don't know yet - that most Linux people know by heart! 
As a Windows user, I will do my best to guide you away from Windows11, and over to the Linux World !!  

For server users and powerusers (_those not afraid of non-gui things like dos, scripting, code, and similar_), i will also write up my experiences with Apline OS!  
(I will link to that here - as soon as I am done writing enough of it - enough to be helful, and enough to be publish-able!)  

I am an somewhat advanced computer user - so I used AI's as teachers whenever I got stuck, after lots of testing!  
And - I can recommend Claude (and also Gwen) as they are both very well versed with Linux !!

<br>

## Now - lets bash Windows into bytes and start this installation:  
[First edition of the Minimal Arch OS install](/arch-minimal-install.md)  

Keep in mind _this guide_ is currently being edited live by me, and the documents in this _git repo_ migh be changed to improve them!  
When all the checkmarks up top of this page is checked - then this guide is fully ready for use - by most people!  
- Until then i recommend you be a _tech savvy programmer alike person_ if you choose to follow this guide before it is fully done!  

<br>

***Sincerely, AlexData !!*** [28.nov.2025]  

<br>

