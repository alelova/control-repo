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
  file_line { 'sudoers_timeout':
    ensure => present,
    path   => '/etc/sudoers',
    line   => "Defaults timestamp_timeout=30",
    match  => "Defaults timestamp_timeout=",
  }

  ###3. Banner
  file {'/etc/issue':
    ensure => file,
    content => "He leido y acepto los terminos de TFM Uned para el uso de este servidor",
  }
  file {'/etc/issue.net':
    ensure => file,
    content => "He leido y acepto los terminos de TFM Uned para el uso de este servidor",
  }

  ###4. Password
  file {'/etc/security/pwquality.conf':
    ensure => file,
    content => "minclass = 4\n minlen = 14\n retry =5",
  }
}
