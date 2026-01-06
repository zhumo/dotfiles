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
  if [ -d "$target" ] && [ ! -L "$target" ]; then
    echo "Removing existing directory $target"
    rm -rf "$target"
  fi
  echo "Linking ~/.claude/$name to $PWD/$item"
  ln -svfi "$PWD/$item" "$target"
done

echo "Cloning vundle into ~/.vim"
echo "If vundle already exists in ~/.vim, then this will give a failure message."
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim

echo "Shortcut to ~/iCloud"
ln -s "/Users/mozhu/Library/Mobile Documents/com~apple~CloudDocs/" ~/iCloud

echo "Shortcut to ~/programming"
ln -s "/Users/mozhu/Library/Mobile Documents/com~apple~CloudDocs/programming/" ~/programming

echo "Script done."
echo "Next when you open vim, run the command :BundleInstall to install the plugins."
echo "You can also add your own plugins to the list."
