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

def main [] {
    print "🚀 Starting system update process..."
    apt-upgrade
}
