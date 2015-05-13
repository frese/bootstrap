class puppet::cron {
  cron { 'puppet':
    command => 'PATH=$PATH:/usr/local/bin; puppet-pull-apply >> /var/log/puppet-cron.log 2>&1',
    user    => root,
    minute  => '*/10'
  }
  file { '/etc/logrotate.d/puppet-cron':
    ensure => present,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/puppet/puppet-cron'
  }
}
