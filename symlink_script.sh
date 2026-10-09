#! /bin/bash

echo "Starting script..."
for source_file in shell/*; do
  filename=$(basename "$source_file")
  echo "Linking ~/.$filename to $PWD/$source_file"
  ln -svfi "$PWD/$source_file" "$HOME/.$filename"
done

echo "Setting up ~/.claude config symlinks"
mkdir -p "$HOME/.claude"
for item in claude/*; do
  name=$(basename "$item")
  target="$HOME/.claude/$name"
  if [ -L "$target" ]; then
    rm -f "$target"
  elif [ -d "$target" ]; then
    rm -rf "$target"
  fi
  echo "Linking ~/.claude/$name to $PWD/$item"
  ln -svfi "$PWD/$item" "$target"
done

echo "Linking ~/.config/nvim to $PWD/nvim"
mkdir -p "$HOME/.config"
ln -svfn "$PWD/nvim" "$HOME/.config/nvim"

echo "Shortcut to ~/programming"
ln -s "/Users/mozhu/Library/Mobile Documents/com~apple~CloudDocs/programming/" ~/programming

echo "Script done."
echo "Plugins install automatically the first time you open nvim."
