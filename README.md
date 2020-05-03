# HddTempSafe

Tool to read hard disk temperature from hddtemp's TCP interface.

[hddtemp](https://github.com/guzu/hddtemp) is a popular CLI tool to retrieve HDD temperature. Due to its small footprint and command-line interface, it is often called by other scripts, like [conky](https://github.com/brndnmtthws/conky). However, running the `hddtemp` directly as a command needs root permission. To be able to use it smoothly from an unpriviledged script, ones often apply a trick: Set SUID bit for the _/usr/sbin/hddtemp_ binary. I feel to grant root permission is too much and want to avoid it. Fortunately, `hddtemp` can run as daemon and provides a TCP interface for normal users to get its data without having to escalating priviledge.

This tool is to help other scripts get HDD temperature from `hddtemp` via that TCP interface. It is written in Lua to keep it lightweight.


## Usage

You can run the tool with `--help` switch to see available options

```
$ hddtemp-safe --help

Usage: hddtemp-safe [-p <port>] [-h] <disk>

Get HDD temperature from hddtemp daemon

Arguments:
   disk                  Disk path, i.e. /dev/sda

Options:
       -p <port>,        hddtemp's listening port (default 7634)
   --port <port>
   -h, --help            Show this help message and exit.

```

To read temperature of */dev/sda*:

```
$ ./hddtemp-safe /dev/sda
39
```
