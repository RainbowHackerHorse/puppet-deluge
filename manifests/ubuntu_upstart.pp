# Class: ubuntu_upstart
# Submodule to provide support for Upstart on Ubuntu

class ubuntu_upstart {
  file {
    '/etc/init/deluged.conf':
        ensure  => file,
        mode    => '0644',
        owner   => root,
        group   => root,
        source  => 'puppet:///modules/deluge/ubuntu_upstart/deluged.conf',
        require => [Package['deluged'], User['deluge']];

    '/etc/init/deluge-web.conf':
        ensure  => file,
        mode    => '0644',
        owner   => root,
        group   => root,
        source  => 'puppet:///modules/deluge/ubuntu_upstart/deluge-web.conf',
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
  logrotate::rule { 'deluge':
    path          => '/var/log/deluge/*.log',
    rotate        => 4,
    rotate_every  => week,
    sharedscripts => true,
    missingok     => true,
    delaycompress => true,
    ifempty       => false,
    compress      => true,
    postrotate    => 'initctl restart deluged ; initctl restart deluge-web';
}
}