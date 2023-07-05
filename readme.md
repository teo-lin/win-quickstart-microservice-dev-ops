Sometimes the first step is the hardest. This aims to simplify getting started with coding. It is a very simple app that batch installs the development tools you need then adds them to the Windows PATH if needed and does some extra quality of life settings.

The initial commit is geared towards web development with node/python etc. I plan to add different paths later. Feel free to contribute

# SETUP via CLI (Command Line Interface)
Run 02-setup-dev-tools-cli.cmd as administrator, select desired tools with y/n

# SETUP via GUI (Graphical User Interface)
Run 00-setup-dev-tools-gui.cmd as administrator, tick desired tools and install

# GITHUB SETUP (First time)
- create a GitHub account
- in terminal, run: 
``` powershell
git config --global user.name "Your Name"
git config --global user.email "youremail@example.com"
git config --global core.editor "code --wait"
```
The last bit sets the default text editor to VS Code, you can replace it with something else