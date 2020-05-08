# HddTempSafe

Tool to read hard disk temperature from hddtemp's TCP interface.

![VN](https://madewithlove.now.sh/vn?heart=true&colorA=%23ffcd00&colorB=%23da251d)

[hddtemp](https://github.com/guzu/hddtemp) is a popular CLI tool to retrieve HDD temperature. Due to its small footprint and command-line interface, it is often called by other scripts, like [conky](https://github.com/brndnmtthws/conky). However, running the `hddtemp` directly as a command needs root permission. To be able to use it smoothly from an unpriviledged script, ones often apply a trick: Set SUID bit for the _/usr/sbin/hddtemp_ binary. I feel to grant root permission is too much and want to avoid it. Fortunately, `hddtemp` can run as daemon and provides a TCP interface for normal users to get its data without having to escalating priviledge.

This tool is to help other scripts get HDD temperature from `hddtemp` via that TCP interface. It is written in Lua (5.3) to remain lightweight.

## Install

### Ubuntu

This software is packaged as _*.deb_ file for Ubuntu and derivatives (Linux Mint etc.). Please install it from [PPA](https://launchpad.net/~ng-hong-quan/+archive/ubuntu/ppa):

```sh
sudo add-apt-repository ppa:ng-hong-quan/ppa
sudo apt-get update
sudo apt install hddtemp-safe
```

### Other distros

For other distros, HddTempSafe can be installed from source.

```sh
git clone https://github.com/hongquan/HddTempSafe.git

cd HddTempSafe

sudo make install

```

You can also install it to local user folder with (without `sudo`):

```sh
make install
```

HddTempSafe will be installed to _~/.local/bin_ folder. Please make sure that this folder is in your `PATH` environment variable. Normally, you don't have to worry if your default shell is Bash and you are using Debian derivative OSes (like Ubuntu, Linux Mint etc.). But if your default shell is Zsh, please check (default config template for Zsh on Ubuntu does not include this folder in `PATH`).

When installing HddTempSafe from source, other software dependencies will not be installed automatically. Please install them yourselves. They are:

- `hddtemp` (of course)
- `lua5.3`
- `lua-luxio`
- `lua-argparse`
- `lua-socket`

Assume that you already installed `hddtemp`. By default, on Debian & Ubuntu, it is not running in daemon mode. You need to configure it to run as daemon by editing _/etc/default/hddtemp_ file, making sure that the file has this line:

```sh
RUN_DAEMON="true"
```

After changing the configuration, you need to start it up:

```sh
sudo systemctl enable --now hddtemp.service
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

## Credit

Brought to you by [Nguyễn Hồng Quân](https://quan.hoabinh.vn/).
