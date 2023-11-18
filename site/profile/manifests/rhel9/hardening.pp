class profile::rhel9::hardening{
  file {'/root/README_hardening':
    ensure => file,
    content => "##File managed by puppet control-repo \nHardening server name: ${fqdn}\n",
  }
  file_line { 'virtual_host':
  ensure => present,
  path   => '/root/README_host',
  line   => "host_name= ${fqdn}",
  match  => 'host_name=',
  }
  
  ###2. Sudo config
  file_line { 'sudoers_default_pty':
  ensure => present,
  path   => '/etc/sudoers',
  line   => "Defaults use_pty",
  match  => "Defaults use",
  }
}
