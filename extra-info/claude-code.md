# CLAUDE CODE
[Claude Code - Home](https://claude.com/product/claude-code)  
[Claude Code Documentation](https://code.claude.com/docs/en/overview)

[Claude.ai (subscription plans - recommended)](https://claude.ai)  

[Claude Console - API access with pre-paid credits](https://console.anthropic.com/)  
[API Dashboard - Buy and manage API credits](https://platform.claude.com/settings/billing)  

### For help directly in the terminal you can use Claude Code.  

Download Claude Code script, to install Claude Code on your virtual or live system!
You may read the script in your browser before you install it...  
Just drop this link into your browser:  `https://claude.ai/install.sh`  
(Their script is stored on _storage.googleapis.com_)   
```bash
curl -fsSL https://claude.ai/install.sh | bash
```

<br>

Select the main folder to give Claude Access to - you may change this later!  
For safety reasons - unmount any hdd, partition, virtual filesystem that you dont want Claude to access!  
Usually you'll have to grant Claude access to other folders -but- I say, better safe than sorry!  
```bash
cd /path/where/you/want/claude/to/Have/access/to/its/project/
```

<br>

Start Claude Code - you will be prompted to logon to your pro account at Anthropics.  
Once logged on, Claude Code will work, and you will have access to it idirectly in the Terminal (Bash, Konsole, CLI)
```bash
claude    # Run this command to log onto Claude Code - so you can use it directly in your CLI / Terminal
```

### Essential commands for daily use with Claude Code: 

```bash
**COMMAND:**          **WHAT IT DOES:**                     **EXAMPLE-COMMANDS:**
  claude                Start interactive mode.	              claude  
  claude "task"	        Run a one-time task.	              claude "fix the build error"  
  claude -p "query"	    Run one-off query, then exit.	      claude -p "explain this function"  
  claude -c	            Continue most recent conversation.    claude -c  
  claude -r	            Resume a previous conversation.	      claude -r  
  claude commit	        Create a Git commit	claude.           commit  
  /clear	            Clear conversation history.           /clear  
  /help	                Show available commands.              /help  
  exit (or Ctrl+C)      Exit Claude Code.                     exit  
```

### Save more time using these shortcuts:  
Press **?** to see all available keyboard shortcuts.  
Use **Tab** for command completion.  
Press **↑** for command history.  
Type **/** to see all slash commands.  
  
[CLI Commands Help Docs - Learn more about claude code commands](https://code.claude.com/docs/en/cli-reference)  

<br>





<br>

```

```


### Using another OS - Install Claude Code with these methods:  

Homebrew (macOS, Linux):  
> brew install --cask claude-code  

macOS, Linux, WSL:  
> curl -fsSL https://claude.ai/install.sh | bash  

Windows PowerShell:
> irm https://claude.ai/install.ps1 | iex  

Windows CMD:  
> curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd  

<br>

```

```
