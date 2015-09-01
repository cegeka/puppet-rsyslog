define rsyslog::config::directives (
  $content = []
)
{
  case $::osfamily {
    'RedHat': {
      file { "/etc/rsyslog.d/${title}.conf":
        ensure   => 'file',
        owner    => 'root',
        group    => 'root',
        mode     => '0644',
        content  => template("${module_name}/config/directives.erb"),
        notify   => 'Service[rsyslog]',
        require  => 'File[/etc/rsyslog.d]'
      }
    }
    default: {
      fail("Rsyslog::Config::Directives[${title}]: osfamily ${::osfamily} is not supported")
    }
  }
}
