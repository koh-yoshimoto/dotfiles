# case of MacOS
git clone https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# フォント
brew tap homebrew/cask-fonts
brew install font-Hack-nerd-font

# キーリピート速度入力
defaults write -g InitialKeyRepeat -int 11
# キー入力認識速度
defaults write -g KeyRepeat -int 1


# tmux
brew install tmux
mkdir -p .local/share/tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm
tmux source ~/.config/tmux/tmux.conf

