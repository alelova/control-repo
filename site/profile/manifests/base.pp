class profile::base{
  user{ 'admin':
    ensure => present,
  }
  file {'/root/README':
    ensure => file,
    content => "Welcome to ${fqdn}\n",
  }
}
