# svim

# oh-my-posh

install oh-my-posh https://ohmyposh.dev/
link config

```
ln -s "$PWD/.my-atomic-theme.omp.json" ~/.my-atomic-theme.omp.json
```

add to .zshrc

```
eval "$(oh-my-posh init zsh --config '~/.my-atomic-theme.omp.json')"
```

exec zsh

# tmux

```
ln -s "$PWD/bin/t" ~/bin/t
```

## Start tmux in item2

iTerm2 -> Preferences (or Settings) -> Profiles -> Command tab
Select "Send text at start"

```
tmux attach -t init || tmux new -s init
```

Ubuntu terminal -> Preference -> Command -> Custom Command
gnome-terminal -- "~/bin/init.sh"

# macos

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
brew install --cask google-chrome
brew install --cask iterm2
brew install neovim
brew install gnupg
brew install tmux
brew install mc
brew install fzf
brew install ripgrep
brew install --cask emacs
brew install --cask firefox
brew install --cask visual-studio-code
brew install --cask font-fira-code
brew install font-hack-nerd-font
brew install mpv
brew install n
# brew install openjdk
brew install --cask zulu@17 # for React Native
brew install uv
brew install tree
brew install btop
```

# Midnight Commander (mc)
```sh
ln -s "$PWD/mc/ini" ~/.config/mc/ini
```
