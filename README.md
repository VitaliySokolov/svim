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
