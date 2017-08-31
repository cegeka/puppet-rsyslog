class rsyslog::service ( $manage_syslog = true) {

  if $manage_syslog {
    service { 'rsyslog':
      ensure     => 'running',
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => [ Package['rsyslog'], Service['syslog'] ],
    }
    service { 'syslog':
      ensure    => 'stopped',
      hasstatus => true,
    }
  } else {
    service { 'rsyslog':
      ensure     => 'running',
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Package['rsyslog'],
    }
  }
}
