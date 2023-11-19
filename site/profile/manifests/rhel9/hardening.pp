class profile::rhel9::hardening{
  file {'/root/README_hardening':
    ensure => file,
    content => "##File managed by puppet control-repo \nHardening server name: ${fqdn}\n",
  }
  
  ###1. grub config
  file {'/boot/grub2/grub.cfg':
    ensure => file,
    mode => '0600',
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
    mode => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S chmod -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S chmod -F auid>=1000 -F auid!=unset -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/11_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S chown -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S chown -F auid>=1000 -F auid!=unset -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/12_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S fchmod -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S fchmod -F auid>=1000 -F auid!=unset -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/13_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S fchmodat -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S fchmodat -F auid>=1000 -F auid!=unset -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/14_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S fchown -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S fchown -F auid>=1000 -F auid!=unset -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/15_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S fchownat -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S fchownat -F auid>=1000 -F auid!=unset -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/16_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S fremovexattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S fremovexattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b32 -S fremovexattr -F auid=0 -F key=perm_mod\n-a always,exit -F arch=b64 -S fremovexattr -F auid=0 -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/17_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S fsetxattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S fsetxattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b32 -S fsetxattr -F auid=0 -F key=perm_mod\n-a always,exit -F arch=b64 -S fsetxattr -F auid=0 -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/18_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S lchown -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S lchown -F auid>=1000 -F auid!=unset -F key=perm_mod\n",
  }
file {'/etc/audit/rules.d/19_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S lremovexattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S lremovexattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b32 -S lremovexattr -F auid=0 -F key=perm_mod\n-a always,exit -F arch=b64 -S lremovexattr -F auid=0 -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/20_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S lsetxattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S lsetxattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b32 -S lsetxattr -F auid=0 -F key=perm_mod\n-a always,exit -F arch=b64 -S lsetxattr -F auid=0 -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/21_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S removexattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S removexattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b32 -S removexattr -F auid=0 -F key=perm_mod\n-a always,exit -F arch=b64 -S removexattr -F auid=0 -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/22_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S setxattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S setxattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b32 -S setxattr -F auid=0 -F key=perm_mod\n-a always,exit -F arch=b64 -S setxattr -F auid=0 -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/23_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-w /var/log/faillock -p wa -k logins\n",
  }
  file {'/etc/audit/rules.d/24_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-w /var/log/lastlog -p wa -k logins\n",
  }
  file {'/etc/audit/rules.d/25_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=unset -F key=export\n-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=unset -F key=export\n",
  }
  file {'/etc/audit/rules.d/26_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-w /var/run/utmp -p wa -k session\n-w /var/log/btmp -p wa -k session\n-w /var/log/wtmp -p wa -k session\n",
  }
  file {'/etc/audit/rules.d/27_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-w /etc/sudoers -p wa -k actions\n-w /etc/sudoers.d/ -p wa -k actions\n",
  }
  file {'/etc/audit/rules.d/28_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-w /etc/group -p wa -k audit_rules_usergroup_modification\n",
  }
  file {'/etc/audit/rules.d/29_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-w /etc/gshadow -p wa -k audit_rules_usergroup_modification\n",
  }
  file {'/etc/audit/rules.d/30_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-w /etc/security/opasswd -p wa -k audit_rules_usergroup_modification\n",
  }
  file {'/etc/audit/rules.d/31_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-w /etc/passwd -p wa -k audit_rules_usergroup_modification\n",
  }
  file {'/etc/audit/rules.d/32_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-w /etc/shadow -p wa -k audit_rules_usergroup_modification\n",
  }
  file {'/etc/audit/rules.d/33_hardening.rules':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\n-w /var/log/sudo.log -p wa -k maintenance\n",
  }
  file_line { 'audit_rotate':
    ensure => present,
    path   => '/etc/audit/auditd.conf',
    line   => "max_log_file_action = rotate",
    match  => "max_log_file_action",
  }
}
