#!/usr/bin/env -S nu

def apt-upgrade [] {
    print "📦 Checking for APT..."
    
    if (which apt | get path | is-empty ) {
       print "ℹ️ APT not installed, skipping APT updates"
       return
    }
    
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
    print "📦 Checking for Flatpak..."
    
    if (which flatpak | get path | is-empty ) {
       print "ℹ️ Flatpak not installed, skipping Flatpak updates"
       return
    }
    
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

def snap-upgrade [] {
    print "📦 Checking for Snap..."

    if (which snap | get path | is-empty ) {
       print "ℹ️ Snap not installed, skipping Snap updates"
       return
    }
    
    print "🔄 Upgrading Snaps..."
    try {
        sudo snap refresh
        print "✅ Snaps updated successfully"
    } catch {
        print "ℹ️ No Snaps to update"
    }
    
    print "✅ Snap updates completed!"
}

def main [] {
    print "🚀 Starting system update process..."
    print "=================================================="
    
    print "\n📦 APT PACKAGE UPDATES"
    print "=================================================="
    apt-upgrade
    
    print "\n📦 FLATPAK PACKAGE UPDATES"
    print "=================================================="
    flatpak-upgrade
    
    print "\n📦 SNAP PACKAGE UPDATES"
    print "=================================================="
    snap-upgrade
    
    print "\n🎉 All package updates completed!"
    print "=================================================="
}
