Sample init scripts and service configuration for electrobytesd
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/electrobytesd.service:    systemd service unit configuration
    contrib/init/electrobytesd.openrc:     OpenRC compatible SysV style init script
    contrib/init/electrobytesd.openrcconf: OpenRC conf.d file
    contrib/init/electrobytesd.conf:       Upstart service configuration file
    contrib/init/electrobytesd.init:       CentOS compatible SysV style init script

1. Service User
---------------------------------

All three Linux startup configurations assume the existence of a "electrobytescore" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes electrobytesd will be set up for the current user.

2. Configuration
---------------------------------

At a bare minimum, electrobytesd requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, electrobytesd will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that electrobytesd and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If electrobytesd is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running electrobytesd without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/electrobytes.conf`.

3. Paths
---------------------------------

3a) Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/electrobytesd`  
Configuration file:  `/etc/electrobytescore/electrobytes.conf`  
Data directory:      `/var/lib/electrobytesd`  
PID file:            `/var/run/electrobytesd/electrobytesd.pid` (OpenRC and Upstart) or `/var/lib/electrobytesd/electrobytesd.pid` (systemd)  
Lock file:           `/var/lock/subsys/electrobytesd` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the electrobytescore user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
electrobytescore user and group.  Access to electrobytes-cli and other electrobytesd rpc clients
can then be controlled by group membership.

3b) Mac OS X

Binary:              `/usr/local/bin/electrobytesd`  
Configuration file:  `~/Library/Application Support/electrobytesCore/electrobytes.conf`  
Data directory:      `~/Library/Application Support/electrobytesCore`
Lock file:           `~/Library/Application Support/electrobytesCore/.lock`

4. Installing Service Configuration
-----------------------------------

4a) systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start electrobytesd` and to enable for system startup run
`systemctl enable electrobytesd`

4b) OpenRC

Rename electrobytesd.openrc to electrobytesd and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/electrobytesd start` and configure it to run on startup with
`rc-update add electrobytesd`

4c) Upstart (for Debian/Ubuntu based distributions)

Drop electrobytesd.conf in /etc/init.  Test by running `service electrobytesd start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

4d) CentOS

Copy electrobytesd.init to /etc/init.d/electrobytesd. Test by running `service electrobytesd start`.

Using this script, you can adjust the path and flags to the electrobytesd program by
setting the XBXD and FLAGS environment variables in the file
/etc/sysconfig/electrobytesd. You can also use the DAEMONOPTS environment variable here.

4e) Mac OS X

Copy org.electrobytes.electrobytesd.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.electrobytes.electrobytesd.plist`.

This Launch Agent will cause electrobytesd to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run electrobytesd as the current user.
You will need to modify org.electrobytes.electrobytesd.plist if you intend to use it as a
Launch Daemon with a dedicated electrobytescore user.

5. Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
