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
  $package_ensure = present,
  $service_status = running,
  $service_enable = true,
  $config_dst = '/etc/rsyslog.conf',
  $config_src = undef,
  $use_default_config = true,
  $config_ensure = $package_ensure,
  $log_perm = '0644',
  $logrotate_exclude_list,
  $logrotate_list = [
    'cron',
    'maillog',
    'messages',
    'secure',
    'spooler'
  ]
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
    service_status => $service_status,
    service_enable => $service_enable
  }

  class { '::rsyslog::config':
    config_dst    => $config_dst,
    config_src    => $real_config_src,
    config_ensure => $config_ensure,
    log_perm      => $log_perm,
    logrotate_exclude_list => $logrotate_exclude_list,
    logrotate_list => $logrotate_list,
    use_default_config => $use_default_config
  }
  Package['rsyslog'] -> Class['::rsyslog::config'] -> Class['::rsyslog::service']
}
