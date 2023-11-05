class profile::rhel9::hardening{
  file {'/root/README_hardening':
    ensure => file,
    content => "##File managed by puppet control-repo \nHardening server name: ${fqdn}\n",
  }
}
