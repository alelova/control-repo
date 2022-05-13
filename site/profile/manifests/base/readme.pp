class profile::base::readme{
  user{ 'admin':
    ensure => present,
  }
  file {'/root/README':
    ensure => file,
    content => "Welcome to ${fqdn}\n",
  }
  file {'/etc/cron.d/apagado':
    ensure => file,
    source => "puppet://modules/%{module_name}/base/cron.d/apagado",
  }
}
