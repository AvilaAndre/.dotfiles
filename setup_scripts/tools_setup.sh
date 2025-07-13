#!/bin/bash

cd ~/.local/bin/

# get_or_update diff-so-fancy
curl -s https://api.github.com/repos/so-fancy/diff-so-fancy/releases/latest | grep "browser_" | cut -d : -f 2,3 | tr -d \" | wget -qi - -O diff-so-fancy
chmod u+x diff-so-fancy
echo "tool: diff-so-fancy installed"

echo "tools installed"

