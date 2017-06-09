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
class rsyslog (
  $package = 'rsyslog',
  $package_ensure = present,
  $config_dst = '/etc/rsyslog.conf',
  $config_src = 'puppet:///modules/rsyslog/rsyslog.conf',
  $config_ensure = present,
  $service_ensure = running,
  $service_enable = true,
  $manage_syslog = true,
  $syslog_ensure = stopped,
  $log_perm = '0644'
) {

  package { $package :
    ensure => $package_ensure,
  }

  file { $config_dst :
    ensure  => $config_ensure,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => $config_src,
    notify  => Service['rsyslog'],
    require => Package['rsyslog'],
  }

  file { '/etc/sysconfig/rsyslog':
    ensure  => $config_ensure,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/rsyslog/rsyslog.sysconfig',
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

  file { '/etc/init.d/rsyslog':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => "puppet:///modules/${module_name}/rsyslog.initd",
    notify  => Service['rsyslog'],
    require => Package['rsyslog'],
  }

  if $manage_syslog {
    service { 'rsyslog':
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasrestart => true,
      hasstatus  => true,
      require    => [ Package['rsyslog'], Service['syslog'] ],
    }
    service { 'syslog':
      ensure    => $syslog_ensure,
      hasstatus => true,
    }
  } else {
    service { 'rsyslog':
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasrestart => true,
      hasstatus  => true,
      require    => Package['rsyslog'],
    }
  }

  file { '/var/log/messages':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => $log_perm,
  }

  file { '/etc/logrotate.d/rsyslog':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => "puppet:///modules/${module_name}/rsyslog.logrotate"
  }

  file { '/etc/logrotate.d/syslog':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    content => ""
  }

}
