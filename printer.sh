#!/usr/bin/env sh

# Figure out which OS I'm on.
# http://stackoverflow.com/questions/394230/detect-the-os-from-a-bash-script

# Figure out which verson of Mac OS X I'm on.
# sw_vers -productVersion

# Download Drivers

# Unzip Driver Zips
# Go through wizard

platform='unknown'
uname_string=`uname`

if [[ "$uname_string" == 'Linux' ]]; then
    platform='linux'
elif [[ "$uname_string" == 'Darwin' ]]; then
    platform='mac'
    sw_vers_str=`sw_vers -productVersion`

    if [[ "$sw_vers_str" == '10.10' ]]; then
        echo 'yo'
        # BUG! Doesn't download zip.
        # curl -O http://onyxftp.mykonicaminolta.com/Downloadfile/Download.ashx?fileversionid=19278&productid=1509
        # unzip C554_C364_Series_v5.2.1_Letter.zip -d ~/Downloads
        # sudo installer -pkg ~/Downloads/C554_C364_Series_v5.2.1_Letter/bizhub_C554_C364_109.pkg -target /
    elif [[ "$sw_vers_str" == '10.9.5' ]]; then
        if [ ! -f Konica-Drivers.zip ]; then
            curl -O http://weprint.wework.com/Konica-Drivers.zip
            unzip Konica-Drivers.zip -d ~/Downloads
            sudo installer -pkg ~/Downloads/Konica\ Drivers/OSX\ 10.9/Setup109.pkg -target /
        fi

        # curl -O http://weprint.wework.com/Kyocera-Drivers.zip
        # unzip Kyocera-Drivers.zip -d ~/Downloads
        # sudo installer -pkg ~/Downloads/Kyocera\ Drivers/OSX/Setup.pkg -target /
    fi
fi 

# Download PaperCut
if [ ! -f PaperCut-OSX.zip ]; then
    curl -O http://weprint.wework.com/PaperCut-OSX.zip
    unzip PaperCut-OSX.zip -d ~/Downloads
fi

# CHALLENGE: Execute pc-client-mac.command & bypass Gatekeeper
# sudo open -a ~/Downloads/PaperCut\ OSX/Setup.app
# sudo open -a ~/Downloads/PaperCut\ OSX/PCClient.app
# sh ~/Downloads/PaperCut\ OSX/pc-client-mac.command

# Agree to prompt: "Do you want to add PCClient to Applications?"
# CHALLENGE: Log in via prompt (?)
# CHALLENGE: "Remember my identity"

# Open ~/Applications/PCClient.app
# CHALLENGE: Add PCClient to Dock
# Start PCClient on boot (chkconfig)

# Add Printer
# lpadmin -p "WeWork" -v "ipp://p.wework.com/printers/WeWork" -D "WeWork (Kyocera)" -P "/Library/Printers/PPDs/Contents/Resources/Kyocera TASKalfa 3051ci.PPD" -E -o printer-is-shared=false
lpadmin -p "WeWork" -v "ipp://p.wework.com/printers/WeWork" -D "WeWork (Minolta)" -P "/Library/Printers/PPDs/Contents/Resources/KONICAMINOLTAC224.gz" -E -o printer-is-shared=false

# Restart cups
# sudo launchctl unload /System/Library/LaunchDaemons/org.cups.cupsd.plist
# sudo launchctl load /System/Library/LaunchDaemons/org.cups.cupsd.plist


# DEBUG

# INFO
# https://s3.amazonaws.com/weprint.wework.com/location-level-instructions/printer-setup.pdf
# http://jamauai.com/2014/02/25/how-to-manage-printers-via-command-line/

# http://www.papercut.com/products/ng/manual/ch-installation-linux.html
# http://www.lehman.cuny.edu/cgi-bin/man-cgi?lpadmin+1
# http://localhost:631/printers/?

