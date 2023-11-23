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
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S chmod -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S chmod -F auid>=1000 -F auid!=unset -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/11_hardening.rules':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S chown -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S chown -F auid>=1000 -F auid!=unset -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/12_hardening.rules':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S fchmod -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S fchmod -F auid>=1000 -F auid!=unset -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/13_hardening.rules':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S fchmodat -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S fchmodat -F auid>=1000 -F auid!=unset -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/14_hardening.rules':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S fchown -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S fchown -F auid>=1000 -F auid!=unset -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/15_hardening.rules':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S fchownat -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S fchownat -F auid>=1000 -F auid!=unset -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/16_hardening.rules':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S fremovexattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S fremovexattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b32 -S fremovexattr -F auid=0 -F key=perm_mod\n-a always,exit -F arch=b64 -S fremovexattr -F auid=0 -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/17_hardening.rules':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S fsetxattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S fsetxattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b32 -S fsetxattr -F auid=0 -F key=perm_mod\n-a always,exit -F arch=b64 -S fsetxattr -F auid=0 -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/18_hardening.rules':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S lchown -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S lchown -F auid>=1000 -F auid!=unset -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/19_hardening.rules':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S lremovexattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S lremovexattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b32 -S lremovexattr -F auid=0 -F key=perm_mod\n-a always,exit -F arch=b64 -S lremovexattr -F auid=0 -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/20_hardening.rules':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S lsetxattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S lsetxattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b32 -S lsetxattr -F auid=0 -F key=perm_mod\n-a always,exit -F arch=b64 -S lsetxattr -F auid=0 -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/21_hardening.rules':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S removexattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S removexattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b32 -S removexattr -F auid=0 -F key=perm_mod\n-a always,exit -F arch=b64 -S removexattr -F auid=0 -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/22_hardening.rules':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-a always,exit -F arch=b32 -S setxattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b64 -S setxattr -F auid>=1000 -F auid!=unset -F key=perm_mod\n-a always,exit -F arch=b32 -S setxattr -F auid=0 -F key=perm_mod\n-a always,exit -F arch=b64 -S setxattr -F auid=0 -F key=perm_mod\n",
  }
  file {'/etc/audit/rules.d/23_hardening.rules':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-w /var/log/faillock -p wa -k logins\n",
  }
  file {'/etc/audit/rules.d/24_hardening.rules':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-w /var/log/lastlog -p wa -k logins\n",
  }
  file {'/etc/audit/rules.d/25_hardening.rules':
    ensure  => file,
    mode    => '0600',
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
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-w /etc/shadow -p wa -k audit_rules_usergroup_modification\n",
  }
  file {'/etc/audit/rules.d/33_hardening.rules':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\n-w /var/log/sudo.log -p wa -k maintenance\n",
  }
  file_line { 'audit_rotate':
    ensure => present,
    path   => '/etc/audit/auditd.conf',
    line   => "max_log_file_action = keep_logs",
    match  => "max_log_file_action",
  }
  
  ###8. firewalld
  package {'firewalld':
    ensure => present,
  }
  service { 'firewalld':
    ensure => 'running',
    enable => 'true',
  }
  firewalld_rich_rule { 'restrict_loopback':
    ensure      => present,
    zone        => 'trusted',
    source      => '127.0.0.1',         
    dest        => { 'address' => '127.0.0.1', 'invert' => true },
    action      => 'drop',
  }
  firewalld_zone { 'trusted':
    ensure      => present,
    interfaces  =>  'lo',
  }
    
  ###9. IPv6
  sysctl { 'net.ipv6.conf.all.disable_ipv6': value => '1' }

  ###10. IPv4
  sysctl { 'net.ipv4.conf.all.accept_redirects': value => '0' }
  sysctl { 'net.ipv4.conf.all.accept_source_route': value => '0' }
  sysctl { 'net.ipv4.conf.all.log_martians': value => '1' }
  sysctl { 'net.ipv4.conf.all.rp_filter': value => '1' }
  sysctl { 'net.ipv4.conf.all.secure_redirects': value => '0' }
  sysctl { 'net.ipv4.conf.default.accept_redirect': value => '0' }
  sysctl { 'net.ipv4.conf.default.log_martians': value => '1' }
  sysctl { 'net.ipv4.conf.default.rp_filter': value => '1' }
  sysctl { 'net.ipv4.conf.default.secure_redirects': value => '0' }
  sysctl { 'net.ipv4.icmp_echo_ignore_broadcasts': value => '1' }
  sysctl { 'net.ipv4.icmp_ignore_bogus_error_responses': value => '1' }
  sysctl { 'net.ipv4.tcp_syncookies': value => '1' }
  sysctl { 'net.ipv4.conf.all.send_redirects': value => '0' }
  sysctl { 'net.ipv4.conf.default.send_redirects': value => '0' }
  sysctl { 'net.ipv4.ip_forward': value => '0' }

  ###11. File permissions
  file {'/etc/modprobe.d/squashfs.conf':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\ninstall squashfs /bin/true\nblacklist squashfs\n",
  }
  file {'/etc/modprobe.d/udf.conf':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\ninstall udf /bin/true\nblacklist udf\n",
  }
  file {'/etc/modprobe.d/usb-storage.conf':
    ensure  => file,
    mode    => '0600',
    content => "##Managed by puppet\ninstall usb-storage /bin/true\nblacklist usb-storage\n",
  }
  sysctl { 'fs.suid_dumpable': value => '0' }
  
  ###12. ssh
  file_line { 'ssh_client_alive':
    ensure => present,
    path   => '/etc/ssh/sshd_config',
    line   => "ClientAliveCountMax 0",
    match  => "^ClientAliveCountMax",
  }
  file {'/etc/ssh/sshd_config.d/00-hardening.conf':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\nBanner /etc/issue.net\n",
  }
  file_line { 'ssh_allow_users_groups':
    ensure => present,
    path   => '/etc/ssh/sshd_config',
    line   => "AllowGroups student,root",
    match  => "^ClientAliveCountMax",
  }
  
  ###13. USB guard
  package {'usbguard':
    ensure => present,
  }
  service { 'usbguard':
    ensure => 'running',
    enable => 'true',
  }
  file {'/etc/usbguard/rules.conf':
    ensure => file,
    mode => '0600',
    content => "##Managed by puppet\nNOT USB allowed in VM\n",
  }
}
