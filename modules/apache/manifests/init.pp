class apache {
  package {'apache2':
    ensure => '2.2.22-1ubuntu1.4',
  }

  service {'apache2':
    ensure => running,
    require => Package['apache2'],
  }

  file {'acid-vhost-logs':
    ensure => 'directory',
    path => '/var/log/apache2/acid',
  }

# Create a virtual host file for our website
  file {'acid-vhost':
    ensure => present,
    path => '/etc/apache2/sites-available/acid.conf',
    owner => 'root',
    group => 'root',
    content => template('apache/vhost.erb'),
    require => [ Package['apache2'], File ['acid-vhost-logs'] ],
  }

  file {'acid-vhost-enable':
    ensure => link,
    path => '/etc/apache2/sites-enabled/acud.conf',
    target => '/etc/apache2/sites-available/acud.conf',
    require => [ Package['apache2'], File['acid-vhost'] ],
    notify => Service['apache2'],
  }

  file {'apache-envvars':
    ensure => present,
    path => '/etc/apache2/envvars',
    owner => 'root',
    group => 'root',
    content => template('apache/envvars.erb'),
    require => Package['apache2'],
    notify => Service['apache2'],
  }

  exec { 'apache_lockfile_permissions':
    command => 'chown -R vagrant:www-data /var/lock/apache2',
    require => Package['apache2'],
    notify => Service['apache2'],
  }
}
