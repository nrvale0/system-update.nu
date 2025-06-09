#!/usr/bin/env -S nu

def apt-upgrade [] {
    print "🔄 Updating package database..."
    try {
        sudo apt update
        print "✅ Package database updated successfully"
    } catch {
        print "❌ Failed to update package database"
        return
    }
    
    print "⬆️ Upgrading packages..."
    try {
        sudo apt upgrade -y
        print "✅ Packages upgraded successfully"
    } catch {
        print "❌ Failed to upgrade packages"
        return
    }
    
    print "🧹 Cleaning up no longer needed packages..."
    try {
        sudo apt autoremove -y
        print "✅ Package cleanup completed"
    } catch {
        print "❌ Failed to clean up packages"
    }
    
    print "✅ System update completed!"
}

def flatpak-upgrade [] {
    print "📦 Upgrading Flatpak applications..."
    
    print "🔄 Upgrading system Flatpaks..."
    try {
        sudo flatpak update -y
        print "✅ System Flatpaks updated successfully"
    } catch {
        print "ℹ️ No system Flatpaks to update"
    }
    
    print "🗑️ Removing end-of-life system Flatpaks..."
    try {
        sudo flatpak uninstall --unused --delete-data -y
        print "✅ End-of-life system Flatpaks removed"
    } catch {
        print "ℹ️ No end-of-life system Flatpaks to remove"
    }
    
    print "🔄 Upgrading user Flatpaks..."
    try {
        flatpak update --user -y
        print "✅ User Flatpaks updated successfully"
    } catch {
        print "ℹ️ No user Flatpaks to update"
    }
    
    print "🗑️ Removing end-of-life user Flatpaks..."
    try {
        flatpak uninstall --user --unused --delete-data -y
        print "✅ End-of-life user Flatpaks removed"
    } catch {
        print "ℹ️ No end-of-life user Flatpaks to remove"
    }
    
    print "✅ Flatpak updates completed!"
}

def main [] {
    print "🚀 Starting system update process..."
    apt-upgrade
    flatpak-upgrade
}
