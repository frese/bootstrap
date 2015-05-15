define users::user_skeleton {
  $user_info = hiera_hash('user_info')
  $info = merge({
    color_terminal => true
  }, $user_info[$name])

  user { $name:
    comment => $info['email'],
    home    => "/home/${name}",
    shell   => '/bin/bash',
    groups  => npsudo,
  }

  group { $name:
    ensure  => present,
  }

  file { "/home/${name}":
    ensure  => directory,
    owner   => $name,
    group   => $name,
    mode    => '0750',
    require => [ User[$name], Group[$name] ]
  }

  file { "/home/${name}/.ssh":
    ensure => directory,
    owner  => $name,
    group  => $name,
    mode   => '0700',
  }

  file { "/home/${name}/.bashrc":
    mode    => '0644',
    owner   => $name,
    group   => $name,
    content => template('users/bashrc.erb'),
  }

  file { "/home/${name}/.bash_profile":
    mode   => '0644',
    owner  => $name,
    group  => $name,
    source => 'puppet:///modules/users/bash_profile'
  }

  create_resources(ssh_authorized_key, $info[keys], {
    ensure => present,
    user => $name,
    require => File["/home/${name}/.ssh"]
  })

}
