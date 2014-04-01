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

  file { '/etc/init.d/rsyslog':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => "puppet:///modules/${module_name}/rsyslog.initd",
    notify  => Service['rsyslog'],
    require => Package['rsyslog'],
  }

  service { 'rsyslog':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => [ Package['rsyslog'], Service['syslog'] ],
  }

  service { 'syslog':
    ensure    => stopped,
    hasstatus => true,
  }

  file { '/var/log/messages':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
  }

}
