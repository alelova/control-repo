class profile::r10k {
  class {'r10k':
    remote => 'https://github.com/alelova/control-repo',
  }
  class {'r10k::webhook::config':
    use_ncollective => false,
    enable_ssl => false,
  }
  class {'r10k::webhook':
    user => 'root',
    group =>'root',
  }
}
