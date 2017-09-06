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
  $config_src = undef,
  $config_ensure = present,
  $log_perm = '0644',
  $manage_syslog = true
) {

  package { 'rsyslog' :
    ensure => $package_ensure,
  }
  if ( $config_src == undef and $::operatingsystemmajrelease == '5' ) {
    $real_config_src = 'puppet:///modules/rsyslog/rsyslog.conf5'
  }
  elsif ( $config_src == undef ) {
    $real_config_src = 'puppet:///modules/rsyslog/rsyslog.conf'
  }
  else {
    $real_config_src = $config_src
  }

  class { '::rsyslog::service':
    manage_syslog => $manage_syslog
  }
  class { '::rsyslog::config':
    config_dst    => $config_dst,
    config_src    => $real_config_src,
    config_ensure => $config_ensure,
    log_perm      => $log_perm
  }
  Package['rsyslog'] -> Class['::rsyslog::config'] -> Class['::rsyslog::service']
}
