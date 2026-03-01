# @iolave's dot files config

## Requirements
### MacOS
```bash
# gnu stow
brew install stow
```

### Fedora
```bash
# deps
sudo dnf install -y stow zsh 

# make zsh the default shell
chsh -s $(which zsh)

# reboot to apply changes
reboot
```

### Debian
```bash
# deps
sudo apt install -y stow zsh 

# make zsh the default shell
chsh -s $(which zsh)

# reboot to apply changes
reboot
```

*If the window manager doesn't start, press ctrl + alt + f[2-6] to login using tty and follow zsh post installation instructions*

Now follow the instructions for your OS.

## Place dot files where they belong
Clone this repo, cd into it and run the following command

### MacOS
```bash
stow -d macos -t $HOME .
stow -d ./apps/macos/nimble-commander -t $HOME/Library/Application\ Support/Nimble\ Commander/Config .
```

### Asahi Fedora
```bash
stow -d asahi-fedora -t $HOME .
```

### Debian
```bash
stow -d debian -t $HOME .
```
