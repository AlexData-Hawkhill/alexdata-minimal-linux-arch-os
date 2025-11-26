# 🐧 Use Python on Linux 🐧

### Usually Python is already installed with the Linux Distro.  
```bash
sudo pacman -S python    # Install Python
```
```bash
pacman -Qs python    # Search for Python related software packages
```

<br>

### Install PIP (Python Installer Package)
```bash
sudo pacman -S python pip    # The PyPA recommended tool for installing Python packages/modules!
```
```bash
pip install --upgrade pip    # Upgrade to the latest PIP version!
```

<br>

### Perhaps install Python Wheel (A built-package format for Python)
```bash
sudo pacman -S python-wheel    # For building wheels (when doing AI related work)
```

<br>

### Make VIRTUAL PYTHON ENVIRONMENT called venv
```bash
python -m venv <venv_name>    # E.g. python -m venv MyFirstLinuxPythonVenv
```
```bash
cd MyFirstLinuxPythonVenv    # Since a venv is basically a py sandbox in a folder
```
```bash
source bin/activate   # Start the venv so you can install modules there, and run code insde the venv!
```

<br>

### Install pip in the venv as well - so you also can donload packages in venv
Unlike with windows, you will notice that packages often get built from scratch.  
You will see messages like "Building wheels for wxpython (pyproject.toml)" when this happens.  
```bash
pip3 install <package-name>    # E.g "pip3 install wxpython"
```
**Example output:**  
> (linux_venv) [alexdata@arch-alexdata linux_venv]$ pip3 install wxpython  
> Collecting wxpython  
>   Downloading wxpython-4.2.4.tar.gz (58.6 MB)  
>      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 58.6/58.6 MB 27.4 MB/s  0:00:02  
>   Installing build dependencies ... done  
>   Getting requirements to build wheel ... done  
>   Preparing metadata (pyproject.toml) ... done  
> Building wheels for collected packages: wxpython  
>   Building wheel for wxpython (pyproject.toml) ... done  
>   Created wheel for wxpython: filename=wxpython-4.2.4-cp313-cp313-linux_x86_64.whl size=152513354 sha256=95f9657ee0bf751e7668127d62cf2c64a797859a96ea6dce17c1e7ec784b34da  
>   Stored in directory: /home/alexdata/.cache/pip/wheels/c6/92/c9/15d71d2a45adaab5a82e935609039222334fc7693eb03046ad  
> Successfully built wxpython  
> Installing collected packages: wxpython  
> Successfully installed wxpython-4.2.4  

<br>

### Empty the PIP cache for temporary files:
```
bashpip cache purge
```
```bash
pip cache remove *
```

<br>

### Script for auto starting any venv:  
Place This Script Inside Any Python Venv Project Folder On Your Machine.  
This Script Will Automatically Start The Python Venv For You!  
Also It Runs A Few Tests That Let You Determine If You'Re In The Correct Venv!  
Modified To Work On Linux: Kde (Konsole), Gnome, Xfce, Alpine Linux, And Fallback To Xterm.  

[.SH Script for auto starting any Python VENV](/scripts/auto-start-python-venv.sh)

<br>

### Other handy VENV and Python related info:  
**Python version in venv:**   
```bash
bashpython --version  
which python # Both show venv python!  
```

**Recreate venv if broken:**  
```bash
bashrm -rf venv_name  
python -m venv venv_name  
source venv_name/bin/activate  
pip install -r requirements.txt  # If you saved them  
```

**Save PIP installed packages:**
```bash
bashpip freeze > requirements.txt  
```

**Install PIP packages from saved list:**  
```bash
bashpip install -r requirements.txt  
```

<br>

