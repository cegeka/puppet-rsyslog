class rsyslog::service (
  $manage_syslog = true,
  $service_ensure = running
) {

  if $manage_syslog {
    service { 'rsyslog':
      ensure     => $service_ensure,
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
      ensure     => $service_ensure,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Package['rsyslog'],
    }
  }
}
