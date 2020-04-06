XCODE="$(xcode-select --print-path)"

echo "Will try resetting xcode first..."
read -n 1 -s -r -p "Press any key to continue"
xcode-select --reset
echo
echo
echo "Try running the npm command again in a different terminal shell."
read -n 1 -s -r -p "Press any key to continue if it did not solve the problem"

if [ -d "$XCODE" ]; then
    echo "xcode exists at path $XCODE"
    echo "Will delete..."
    read -n 1 -s -r -p "Press any key to continue"
    rm -rf "$XCODE"
fi

echo
echo
echo "Will prompt to install xcode now"
read -n 1 -s -r -p "Press any key to continue"
xcode-select --install
echo
echo
read -n 1 -s -r -p "Press any key when xcode is done installing"
echo
echo
echo "Installing latest npm and latest node-gyp"
npm install -g npm@latest
npm install -g node-gyp@latest