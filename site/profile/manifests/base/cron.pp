class profile::base::cron {
  file {'/etc/cron.d/apagado':
    ensure => file,
    source => 'puppet:///modules/profile/base/cron.d/apagado',
  }
}
