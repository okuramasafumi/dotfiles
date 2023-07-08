set -eu

DOTFILES_PATH="$HOME/dotfiles"

printf "Installing dotfiles...\n"

ln -fhs "$DOTFILES_PATH/bin" "$HOME/bin"
ln -fhs "$DOTFILES_PATH/editor/editorconfig" "$HOME/.editorconfig"
ln -fhs "$DOTFILES_PATH/ruby/gemrc" "$HOME/.gemrc"
ln -fhs "$DOTFILES_PATH/git/gitconfig" "$HOME/.gitconfig"
ln -fhs "$DOTFILES_PATH/git/gitignore" "$HOME/.gitignore"
ln -fhs "$DOTFILES_PATH/ruby/irbrc" "$HOME/.irbrc"
ln -fhs "$DOTFILES_PATH/ruby/ruby-version" "$HOME/.ruby-version"
ln -fhs "$DOTFILES_PATH/vim" "$HOME/.vim"
ln -fhs "$HOME/.vim/vimrc" "$HOME/.vimrc"
ln -fhs "$DOTFILES_PATH/zsh" "$HOME/.zsh"
ln -fhs "$HOME/.zsh/zshrc" "$HOME/.zshrc"
mkdir -p "$HOME/.config"
ln -fhs "$DOTFILES_PATH/karabiner" "$HOME/.config/karabiner"
mkdir -p "$HOME/.config/sheldon"
ln -fhs "$DOTFILES_PATH/zsh/plugins.toml" "$HOME/.config/sheldon/plugins.toml"
mkdir -p "$HOME/.config/nvim"
ln -fhs "$DOTFILES_PATH/nvim/init.lua" "$HOME/.config/nvim/init.lua"

brew bundle --file="$DOTFILES_PATH/Brewfile"

sh "$DOTFILES_PATH/macos/defaults.sh"

printf "dotfiles installed\n"
