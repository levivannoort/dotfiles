# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# show hidden files by default
defaults write com.apple.Finder AppleShowAllFiles -bool false

# show the ~/Library folder in Finder
chflags nohidden ~/Library

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Disable window animations and Get Info animations in Finder
defaults write com.apple.finder DisableAllAnimations -bool true

# Show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false