class rsyslog::service (
  $service_status = running,
  $service_enable = true
) {

  service { 'rsyslog':
    ensure  => $service_status,
    enable  => $service_enable,
    require => [
      Package['rsyslog']
    ]
  }

}
