class repository {
 
  exec { 'import-key':
    path    => '/bin:/usr/bin',
    command => 'curl http://repos.servergrove.com/servergrove-ubuntu-precise/servergrove-ubuntu-precise.gpg.key | apt-key add -',
    unless  => 'apt-key list | grep servergrove-ubuntu-precise',
    require => Package['curl'],
  }
 
  file { 'servergrove.repo':
    path    => '/etc/apt/sources.list.d/servergrove.list',
    ensure  => present,
    content => 'deb http://repos.servergrove.com/servergrove-ubuntu-precise precise main',
    require => Exec['import-key'],
  }
 
  exec { 'apt-get-update':
    command => 'apt-get update',
    path    => ['/bin', '/usr/bin'],
    require => File['servergrove.repo'],
  }
}
 
stage { pre: before => Stage[main] }
 
class { 'repository':
  stage => pre
}
