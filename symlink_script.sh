#! /bin/bash

echo "Starting script..."
for source_file in shell/*; do
  filename=$(basename "$source_file")
  echo "Linking ~/.$filename to $PWD/$source_file"
  ln -svfi "$PWD/$source_file" "$HOME/.$filename"
done

echo "Creating claude directory if it doesn't exist"
mkdir -p "$HOME/.claude"

echo "Linking ~/.claude/CLAUDE.md to $PWD/claude"
ln -svfi "$PWD/claude" "$HOME/.claude/CLAUDE.md"

echo "Cloning vundle into ~/.vim"
echo "If vundle already exists in ~/.vim, then this will give a failure message."
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim

echo "Script done."
echo "Next when you open vim, run the command :BundleInstall to install the plugins."
echo "You can also add your own plugins to the list."
