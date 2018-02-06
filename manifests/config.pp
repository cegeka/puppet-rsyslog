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
class rsyslog::config (
  $config_dst = '/etc/rsyslog.conf',
  $config_src = 'puppet:///modules/rsyslog/rsyslog.conf',
  $config_ensure = present,
  $log_perm = '0644',
  $logrotate_exclude_list,
  $logrotate_list
) {

 case $::operatingsystemmajrelease {
   '5': {
     $syslog_opts='-c3 -i /var/run/rsyslogd.pid'
   }
   '6': {
     $syslog_opts='-c5 -i /var/run/rsyslogd.pid'
   }
   '7': {
     $syslog_opts='-i /var/run/rsyslogd.pid'
   }
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
    ensure   => $config_ensure,
    owner    => root,
    group    => root,
    mode     => '0644',
    content  => template('rsyslog/config/rsyslog.sysconfig.erb'),
    notify   => Service['rsyslog'],
    require  => Package['rsyslog'],
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

  file { '/var/log/messages':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => $log_perm,
  }

  file { '/etc/logrotate.d/rsyslog':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('rsyslog/config/rsyslog.logrotate.erb')
  }

  file { '/etc/logrotate.d/syslog':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    content => ""
  }

}
