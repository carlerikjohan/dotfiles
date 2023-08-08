#######################################
# This script sets some (according to me) some sane defaults.
#
# Inspiration / stolen from:
# - https://github.com/kevinSuttle/macOS-Defaults/blob/master/.macos
# - https://macos-defaults.com/
#######################################

#######################################
# Dock
#######################################

# Set dock icon size to 36 pixels
defaults write com.apple.dock "tilesize" -int "36"

# Set autohide to true
defaults write com.apple.dock "autohide" -bool "true"

# Set autohide animation time to 0.5 seconds
defaults write com.apple.dock "autohide-time-modifier" -float "0.5"

# Hide recent items in dock 
defaults write com.apple.dock "show-recents" -bool "false"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

#######################################
# Screenshot
#######################################

# Create screenshot folder
mkdir ~/Pictures/Screenshots
# Set default screenshot folder to screenshots
defaults write com.apple.screencapture "location" -string "~/Pictures/Screenshots"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

#######################################
# Finder
#######################################

# Enable quit option to Finder
defaults write com.apple.finder "QuitMenuItem" -bool "true"

# Turn on showing extensions for files
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# Turns on showing hidden files
defaults write com.apple.Finder "AppleShowAllFiles" -bool "true" && killall Finder

# Turns off changing file extension warning
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"

# Disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Set Home as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show the ~/Library folder
chflags nohidden ~/Library

#######################################
# Developer helps
#######################################

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

#######################################
# Trackpad / mouse / keyboard
#######################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2 # fastest in dialog
defaults write NSGlobalDomain InitialKeyRepeat -int 15 # fastest in dialog

#######################################
# Screen
#######################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0


#######################################
# Finally apply settings
#######################################
for app in "cfprefsd" \
    "Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done
