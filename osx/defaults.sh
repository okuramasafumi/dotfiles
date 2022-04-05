# Show hidden files
defaults write com.apple.finder AppleShowAllFiles YES && killall Finder

# Function key
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool YES

# Tap to click
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Swipe direction is the direction of finger move
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool NO

# Dock
defaults write com.apple.dock autohide -bool YES && killall Dock
defaults write com.apple.dock tilesize -int 40

# Launchpad to Top Left
defaults write com.apple.dock wvous-tl-corner -int 11

# Notification Center to top right
defaults write com.apple.dock wvous-tr-corner -int 12

# Application windows to bottom right
defaults write com.apple.dock wvous-br-corner -int 3

# Desktop to bottom left
defaults write com.apple.dock wvous-bl-corner -int 4

killall Dock


# Gestures
defaults write com.apple.dock showMissionControlGestureEnabled -bool true
defaults write com.apple.dock showAppExposeGestureEnabled -bool true
defaults write com.apple.dock showDesktopGestureEnabled -bool true
defaults write com.apple.dock showLaunchpadGestureEnabled -bool true

# Dock icon = CPU Usage
defaults write com.apple.ActivityMonitor IconType -int 5

# Screensaver
# Ask for password after 60 seconds
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 60

# Do not write RAM backup during sleep
# See: https://aotamasaki.hatenablog.com/entry/intelmac_crash_during_sleep
pmset hibernatemode 0
