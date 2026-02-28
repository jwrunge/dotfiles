if ! command -v brew &> /dev/null; then
  echo "Homebrew not found. Please install Homebrew."
else
  brew install fish
  brew install helix
  brew install git
  brew install copilot-cli
  brew install gh

  # cli utils
  brew install tre-command
  brew install bat
  brew install eza
  brew install jq
  brew install lazygit
  brew install zoxide
  brew install fzf
  brew install ripgrep
fi
