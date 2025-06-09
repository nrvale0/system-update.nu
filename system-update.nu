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

def guix-upgrade [] {
    print "📦 Checking for Guix..."

    if (which guix | get path | is-empty ) {
       print "ℹ️ Guix not installed, skipping Guix updates"
       return
    }
    
    print "📦 Upgrading Guix packages..."
    
    print "🔄 Upgrading root Guix packages..."
    try {
        sudo guix pull
        sudo guix package -u
        print "✅ Root Guix packages updated successfully"
    } catch {
        print "ℹ️ No root Guix packages to update"
    }
    
    print "🔄 Installing/updating nss-certs for root..."
    try {
        sudo guix install nss-certs
        print "✅ Root nss-certs updated successfully"
    } catch {
        print "ℹ️ Root nss-certs already up to date"
    }
    
    print "🔄 Upgrading user Guix packages..."
    try {
        guix pull
        guix package -u
        print "✅ User Guix packages updated successfully"
    } catch {
        print "ℹ️ No user Guix packages to update"
    }
    
    print "🔄 Installing/updating nss-certs for user..."
    try {
        guix install nss-certs
        print "✅ User nss-certs updated successfully"
    } catch {
        print "ℹ️ User nss-certs already up to date"
    }
    
    print "🗑️ Cleaning up old root generations (>30 days)..."
    try {
        sudo guix package --delete-generations=30d
        print "✅ Old root generations removed"
    } catch {
        print "ℹ️ No old root generations to remove"
    }
    
    print "🗑️ Cleaning up old user generations (>30 days)..."
    try {
        guix package --delete-generations=30d
        print "✅ Old user generations removed"
    } catch {
        print "ℹ️ No old user generations to remove"
    }
    
    print "🧹 Running garbage collection for root..."
    try {
        sudo guix gc
        print "✅ Root garbage collection completed"
    } catch {
        print "ℹ️ Root garbage collection had no effect"
    }
    
    print "🧹 Running garbage collection for user..."
    try {
        guix gc
        print "✅ User garbage collection completed"
    } catch {
        print "ℹ️ User garbage collection had no effect"
    }
    
    print "✅ Guix updates completed!"
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
    
    print "\n📦 GUIX PACKAGE UPDATES"
    print "=================================================="
    guix-upgrade
    
    print "\n🎉 All package updates completed!"
    print "=================================================="
}
