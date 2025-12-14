* Directory structure

```sh
# macos vs code directory
ls ~/Library/Application\ Support/Code/User/

# copy
cp vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
cp vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# diff
diff vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
diff vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# remove existing files
rm ~/Library/Application\ Support/Code/User/keybindings.json
rm ~/Library/Application\ Support/Code/User/settings.json

# link
ln -s $PWD/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -s $PWD/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
```

