# HddTempSafe

Tool to read hard disk temperature from hddtemp's TCP interface.

[hddtemp](https://github.com/guzu/hddtemp) is a popular CLI tool to retrieve HDD temperature. Due to its small footprint and command-line interface, it is often called by other scripts, like [conky](https://github.com/brndnmtthws/conky). However, running the `hddtemp` directly as a command needs root permission. To be able to use it smoothly from an unpriviledged script, ones often apply a trick: Set SUID bit for the _/usr/sbin/hddtemp_ binary. I feel to grant root permission is too much and want to avoid it. Fortunately, `hddtemp` can run as daemon and provides a TCP interface for normal users to get its data without having to escalating priviledge.

This tool is to help other scripts get HDD temperature from `hddtemp` via that TCP interface. It is written in Lua (5.3) to remain lightweight.

## Install

I'm trying to package HddTempSafe as *\*.deb* file, to let Lua dependency libraries automatically installed. In the mean time, please install them manually with this command (example for Ubuntu):


```
sudo apt install lua-luxio lua-argparse
```

Download the script and save to _~/.local/bin_ folder:

```sh
wget https://raw.githubusercontent.com/hongquan/HddTempSafe/master/hddtemp-safe -P ~/.local/bin && chmod a+x ~/.local/bin/hddtemp-safe
```

Make sure that _~/.local/bin_ folder is in your `PATH` environment variable. Normally, you don't have to worry if your default shell is Bash and you are using Debian derivative OSes (like Ubuntu, Linux Mint etc.). But if your default shell is Zsh, please check (default config template for Zsh on Ubuntu does not include this folder in `PATH`).

Assume that you already installed `hddtemp`. By default, on Debian & Ubuntu, it is not running in daemon mode. You need to configure it to run as daemon by edting _/etc/default/hddtemp_ file, make sure to have this line:

```sh
RUN_DAEMON="true"
```

After changing the configuration, you need to start it up:

```sh
sudo systemctl start hddtemp.service
```


## Usage

You can run the tool with `--help` switch to see available options:

```
$ hddtemp-safe --help

Usage: hddtemp-safe [-p <port>] [-h] <disk>

Get HDD temperature from hddtemp daemon

Arguments:
   disk                  Disk path, e.g. /dev/sda

Options:
       -p <port>,        hddtemp's listening port (default 7634)
   --port <port>
   -h, --help            Show this help message and exit.

```

To read temperature of */dev/sda*:

```
$ hddtemp-safe /dev/sda
39
```
