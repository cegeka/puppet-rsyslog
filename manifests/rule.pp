define rsyslog::rule (
  $facility    = undef,
  $level       = 'info',
  $destination = undef
)
{
  case $::osfamily {
    'RedHat': {
      file { "/etc/rsyslog.d/${title}.conf":
        ensure  => 'file',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => "${facility}.${level}  ${destination}\n",
        notify  => 'Service[rsyslog]',
      }
    }
    default: {
      fail("Rsyslog::Rule[${title}]: osfamily ${::osfamily} is not supported")
    }
  }
}
