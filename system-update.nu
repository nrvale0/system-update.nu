#!/usr/bin/env -S nu

def apt-upgrade [] {
    print "🔄 Updating package database..."
    sudo apt update
    
    print "⬆️ Upgrading packages..."
    sudo apt upgrade -y
    
    print "✅ System update completed!"
}

def main [] {
    print "🚀 Starting system update process..."
    apt-upgrade
}
