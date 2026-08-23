#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    glu    \
    libvpx \
    sdl2

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano gtk2-mini libdecor-mini

echo "Building NBlood..."
echo "---------------------------------------------------------------"
REPO="https://github.com/NBlood/NBlood"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone "$REPO" ./NBlood
echo "$VERSION" > ~/version

cd ./NBlood
make blood -j$(nproc)
mv -v nblood /usr/bin
mkdir -p /usr/share/games/nblood
mv -v nblood.pk3 /usr/share/games/nblood
