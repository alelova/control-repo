class profile::rhel9::hardening{
  file {'/root/README_hardening':
    ensure => file,
    content => "hardener by control-repo \n",
  }
}
