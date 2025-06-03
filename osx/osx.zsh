# finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# show hidden files by default
defaults write com.apple.Finder AppleShowAllFiles -bool true

# don't create .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# show the ~/Library folder in Finder
chflags nohidden ~/Library

# automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# disable window animations and Get Info animations in Finder
defaults write com.apple.finder DisableAllAnimations -bool true

# show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false