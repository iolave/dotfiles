# @iolave's dot files config

> [!IMPORTANT]
> This repository was migrated to codeberg.
> 
> Please refer to [codeberg.org:mice1337/config](https://codeberg.org/mice1337/config)

## Dependencies
```bash
# gnu stow
brew install stow # macOS
```

## Place dot files where they belong
Clone this repo, cd into it and run the following command

```bash
stow -d src -t $HOME .
stow -d ./apps/nimble-commander -t $HOME/Library/Application\ Support/Nimble\ Commander/Config .
```
