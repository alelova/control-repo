class profile::base::readme{
  user{ 'admin':
    ensure => present,
  }
  file {'/root/README':
    ensure => file,
    content => "##Gestionado por puppet control-repo",
    content => "Welcome to ${fqdn}\n",
  }
}
