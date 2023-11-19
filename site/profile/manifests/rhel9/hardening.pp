class profile::rhel9::hardening{
  file {'/root/README_hardening':
    ensure => file,
    content => "##File managed by puppet control-repo \nHardening server name: ${fqdn}\n",
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

  ###4. Password quality
  file {'/etc/security/pwquality.conf':
    ensure => file,
    content => "minclass = 4\nminlen = 14\nretry =3",
  }

  ###5. Password expiration
  file_line { 'pass_max_days':
    ensure => present,
    path   => '/etc/login.defs',
    line   => "PASS_MAX_DAYS 45",
    match  => "^PASS_MAX_DAYS",
  }
  file_line { 'pass_min_days':
    ensure => present,
    path   => '/etc/login.defs',
    line   => "PASS_MIN_DAYS 2",
    match  => "^PASS_MIN_DAYS",
  }
  file_line { 'pass_warn_age':
    ensure => present,
    path   => '/etc/login.defs',
    line   => "PASS_WARN_AGE 10",
    match  => "^PASS_WARN_AGE",
  }

  ###6. Root Logins
  file_line { 'group_required_for_su':
    ensure => present,
    path   => '/etc/pam.d/su',
    line   => "auth required pam_wheel.so use_uid",
  }

  ###7. Audit records
  file {'/etc/audit/rules.d/10_hardening.rules':
    ensure => file,
    mode => '0666',
    content => "##Managed by puppet\n-a always,exit -F arch=b64 -S chmod -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S chmod -F auid>=1000 -F auid!=unset -F key=perm_mod",
 }
 file {'/etc/audit/rules.d/11_hardening.rules':
    ensure => file,
    mode => '0666',
    content => "##Managed by puppet\n-a always,exit -F arch=b64 -S chown -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S chown -F auid>=1000 -F auid!=unset -F key=perm_mod",
 }
 file {'/etc/audit/rules.d/12_hardening.rules':
    ensure => file,
    mode => '0666',
    content => "##Managed by puppet\n-a always,exit -F arch=b64 -S fchmod -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S fchmod -F auid>=1000 -F auid!=unset -F key=perm_mod",
 }
}
