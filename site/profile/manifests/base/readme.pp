class profile::base::readme{
  user{ 'admin':
    ensure => present,
  }
  file {'/root/README':
    ensure => file,
    content => "Welcome to ${fqdn}\n",
  }
}
