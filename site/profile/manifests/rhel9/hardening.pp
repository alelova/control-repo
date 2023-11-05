class profile::rhel9::hardening{
  file {'/root/README':
    ensure => file,
    content => "hardener by control-repo \n",
  }
}
