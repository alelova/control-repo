class profile::rhel9::hardening{
  file {'/root/README_hardening':
    ensure => file,
    content => "##File managed by puppet control-repo \nHardening server name: ${fqdn}\n",
  }
  file_line { 'virtual_host':
  ensure => present,
  path   => '/root/README_hardening',
  line   => "host_name= puppet-config",
  match  => 'host_name=',
  }
}
