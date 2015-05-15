class users::users($names) {

# Being in the npsudo group grants password-less access to sudo
  group { 'npsudo':
    ensure => present,
  }

  file { '/etc/sudoers.d/10-npsudo':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => '%npsudo   ALL=(ALL) NOPASSWD:ALL',
    require => Group['npsudo']
  }

  users::user_skeleton { $names: }

  $info = {
    color_terminal => true
  }

  file { '/root/.bashrc':
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template('users/bashrc.erb'),
  }

  file { '/root/.bash_profile':
    mode   => '0644',
    owner  => root,
    group  => root,
    source => 'puppet:///modules/users/bash_profile'
  }
}
