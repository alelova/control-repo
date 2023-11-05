class profile::base::readme{
  user{ 'admin':
    ensure => present,
  }
  file {'/root/README':
    ensure => file,
    content => "##Gestionado por puppet control-repo \n Servidor: ${fqdn}\n",
  }
}
