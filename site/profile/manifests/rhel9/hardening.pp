class profile::base::hardening{
  file {'/root/README':
    ensure => file,
    content => "hardener by control-repo \n",
  }
}
