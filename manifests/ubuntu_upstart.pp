# Class: ubuntu_upstart
# Submodule to provide support for Upstart on Ubuntu

class ubuntu_upstart {
  file {
    '/etc/init/deluged.conf':
        ensure  => file,
        mode    => '0644',
        owner   => root,
        group   => root,
        source  => 'puppet:///modules/deluge/ubuntu/deluged.conf',
        require => [Package['deluged'], User['deluge']];

    '/etc/init/deluge-web.conf':
        ensure  => file,
        mode    => '0644',
        owner   => root,
        group   => root,
        source  => 'puppet:///modules/deluge/ubuntu/deluge-web.conf',
        require => [Package['deluge-web'], User['deluge']];
  }
  service {
    'deluged':
      ensure    => running,
      provider  => upstart,
      subscribe => File['/etc/init/deluged.conf'];

    'deluge-web':
      ensure    => running,
      provider  => upstart,
      subscribe => File['/etc/init/deluge-web.conf'];
  }
}