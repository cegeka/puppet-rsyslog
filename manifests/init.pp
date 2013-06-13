# Class: rsyslog
#
# This module manages rsyslog
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class rsyslog {

  package { 'rsyslog':
    ensure => present,
  }

  file { '/etc/rsyslog.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => "puppet:///modules/${module_name}/rsyslog.conf",
    notify  => Service['rsyslog'],
    require => Package['rsyslog'],
  }

  file { '/etc/rsyslog.d':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0755',
    notify  => Service['rsyslog'],
    require => Package['rsyslog'],
  }

  service { 'rsyslog':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['rsyslog'],
  }

  file { '/var/log/messages':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
  }

}
