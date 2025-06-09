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
        print "✅ System update completed!"
    } catch {
        print "❌ Failed to upgrade packages"
    }
}

def flatpak-upgrade [] {
    print "📦 Upgrading Flatpak applications..."
    
    print "🔄 Upgrading system Flatpaks..."
    try {
        sudo flatpak update -y
        print "✅ System Flatpaks updated successfully"
    } catch {
        print "❌ Failed to update system Flatpaks (or none installed)"
    }
    
    print "🔄 Upgrading user Flatpaks..."
    try {
        flatpak update --user -y
        print "✅ User Flatpaks updated successfully"
    } catch {
        print "❌ Failed to update user Flatpaks (or none installed)"
    }
    
    print "✅ Flatpak updates completed!"
}

def main [] {
    print "🚀 Starting system update process..."
    apt-upgrade
    flatpak-upgrade
}
