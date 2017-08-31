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
  $package_ensure = 'present'
) {

  package { 'rsyslog' :
    ensure => $package_ensure,
  }

  class { '::rsyslog::service':
    manage_syslog => true
  }
  class { '::rsyslog::config':
  }
  Package['rsyslog'] -> Class['::rsyslog::config'] -> Class['::rsyslog::service']
}
