
Debian
====================
This directory contains files used to package electrobytesd/electrobytes-qt
for Debian-based Linux systems. If you compile electrobytesd/electrobytes-qt yourself, there are some useful files here.

## electrobytes: URI support ##


electrobytes-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install electrobytes-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your electrobytes-qt binary to `/usr/bin`
and the `../../share/pixmaps/electrobytes128.png` to `/usr/share/pixmaps`

electrobytes-qt.protocol (KDE)

