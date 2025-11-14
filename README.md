# @iolave's dot files config

## Dependencies
### MacOS
```bash
# gnu stow
brew install stow # macOS
```

## Place dot files where they belong
Clone this repo, cd into it and run the following command

### MacOS
```bash
stow -d macos -t $HOME .
stow -d ./apps/macos/nimble-commander -t $HOME/Library/Application\ Support/Nimble\ Commander/Config .
```
