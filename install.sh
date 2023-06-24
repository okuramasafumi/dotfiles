set -eu

DOTFILES_PATH="$HOME/dotfiles"

printf "Installing dotfiles...\n"

ln -s "$DOTFILES_PATH/bin" "$HOME/bin"
ln -s "$DOTFILES_PATH/editor/editorconfig" "$HOME/.editorconfig"
ln -s "$DOTFILES_PATH/ruby/gemrc" "$HOME/.gemrc"
ln -s "$DOTFILES_PATH/git/gitconfig" "$HOME/.gitconfig"
ln -s "$DOTFILES_PATH/git/gitignore" "$HOME/.gitignore"
ln -s "$DOTFILES_PATH/ruby/irbrc" "$HOME/.irbrc"
ln -s "$DOTFILES_PATH/ruby/ruby-version" "$HOME/.ruby-version"
ln -s "$DOTFILES_PATH/vim" "$HOME/.vim"
ln -s "$HOME/.vim/vimrc" "$HOME/.vimrc"
ln -s "$DOTFILES_PATH/zsh" "$HOME/.zsh"
ln -s "$HOME/.zsh/zshrc" "$HOME/.zshrc"
mkdir "$HOME/.config"
ln -s "$DOTFILES_PATH/karabiner" "$HOME/.config/karabiner"
mkdir "$HOME/.config/nvim"
# Temporary solution, I'm goint to migrate to init.lua
ln -s "$HOME/.vimrc" "$HOME/.config/nvim/init.vim"
ln -s "$HOME/.vimrc" "$HOME/.config/nvim/init.nvim"

sudo "$DOTFILES_PATH/macos/defaults.sh"

printf "dotfiles installed\n"
