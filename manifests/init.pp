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
  $package_ensure = 'present',
  $config_dst = '/etc/rsyslog.conf',
  $config_src = 'puppet:///modules/rsyslog/rsyslog.conf',
  $config_ensure = present,
  $log_perm = '0644',
  $manage_syslog = true
) {

  package { 'rsyslog' :
    ensure => $package_ensure,
  }

  class { '::rsyslog::service':
    manage_syslog => $manage_syslog
  }
  class { '::rsyslog::config':
    config_dst    => $config_dst,
    config_src    => $config_src,
    config_ensure => $config_ensure,
    log_perm      => $log_perm
  }
  Package['rsyslog'] -> Class['::rsyslog::config'] -> Class['::rsyslog::service']
}
