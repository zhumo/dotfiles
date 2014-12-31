#! /bin/bash

echo "Starting script..."
for source_file in *; do
  if [ $source_file != 'symlink_script.sh' ]; then
    echo "Linking ~/.$source_file to $PWD/$source_file"
    ln -svfi "$PWD/$source_file" "$HOME/.$source_file"
  fi
done

<<Comment
#WHEN IN DOUBT, UNCOMMENT THIS!
ln -svfi ~/Dropbox/dotfiles/.bashrc ~/
ln -svfi ~/Dropbox/dotfiles/.vimrc ~/
ln -svfi ~/Dropbox/dotfiles/.bash_profile ~/
ln -svfi ~/Dropbox/dotfiles/.gemrc ~/
ln -svfi ~/Dropbox/dotfiles/.gitconfig ~/
ln -svfi ~/Dropbox/dotfiles/.irbrc ~/
ln -svfi ~/Dropbox/dotfiles/.profile ~/
ln -svfi ~/Dropbox/dotfiles/.pryrc ~/
ln -svfi ~/Dropbox/dotfiles/.rspec ~/
Comment


echo "Cloning vundle into ~/.vim"
echo "If vundle already exists in ~/.vim, then this will give a failure message."
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

echo "Script done."
echo "Next when you open vim, run the command :BundleInstall to install the plugins."
echo "You can also add your own plugins to the list."
