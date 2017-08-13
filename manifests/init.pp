# Class to install and configure deluge daemon
class deluge {

    package {
        'deluged':
            ensure => present;

        'deluge-web':
            ensure => present;
    }

    group {
        'deluge':
            ensure => present,
            system => true;
    }

    user {
        'deluge':
            ensure     => present,
            home       => '/var/lib/deluge',
            managehome => true,
            system     => true,
            gid        => 'deluge',
            require    => Group['deluge'];
    }


    file {
        '/var/log/deluge':
            ensure => directory,
            mode   => '0750',
            owner  => deluge,
            group  => deluge;

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

