puppet-deluge
=============

Puppet Module for the Deluge Bittorrent Client

## Supported OSes
Ubuntu (with Upstart)
FreeBSD

## Usage
To use this module, simply add `include deluge` to your existing puppetfile.
Please note that you must specify the OS and `init` you use as well.

An example, using Ubuntu with `upstart` would be:
`include deluge`
`include deluge::ubuntu_upstart`

To use FreeBSD, one would do as follows:
`include deluge`
`include deluge::freebsd`