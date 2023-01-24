define rsyslog::rule (
  $facility    = undef,
  $level       = 'info',
  $destination = undef,
  $ensure      = 'file'
)
{
  case $::osfamily {
    'RedHat': {
      file { "/etc/rsyslog.d/${title}.conf":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => "${facility}.${level}  ${destination}\n",
        notify  => 'Service[rsyslog]',
        require => 'File[/etc/rsyslog.d]'
      }
    }
    default: {
      fail("Rsyslog::Rule[${title}]: osfamily ${::osfamily} is not supported")
    }
  }
}
