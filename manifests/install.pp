class kylin::install {

  file { $kylin::download_dir:
    ensure => directory,
    owner  => $kylin::kylin_user,
    group  => $kylin::kylin_group,
  }

  file { $kylin::extract_dir:
    ensure => directory,
    owner  => $kylin::kylin_user,
    group  => $kylin::kylin_group,
  }

  file { $kylin::log_dir:
    ensure => directory,
    owner  => $kylin::kylin_user,
    group  => $kylin::kylin_group,
  }

  file { $kylin::pid_dir:
    ensure => directory,
    owner  => $kylin::user,
    group  => $kylin::group,
  }

  if $kylin::package_name == undef {
    include '::archive'

    archive { "${kylin::download_dir}/${kylin::basefilename}":
      ensure          => present,
      extract         => true,
      extract_command => 'tar xfz %s --strip-components=1',
      extract_path    => $kylin::extract_dir,
      source          => $kylin::package_url,
      creates         => "${kylin::extract_dir}/bin",
      cleanup         => true,
      user            => $kylin::kylin_user,
      group           => $kylin::kylin_group,
      require         => [
        File[ $kylin::download_dir ],
        File[ $kylin::extract_dir ],
        Group[ $kylin::kylin_group ],
        User[ $kylin::kylin_user ],
      ],
      before          => File[ $kylin::install_dir ],
    }
  } else {
    package { $kylin::package_name:
      ensure => $kylin::package_ensure,
      before => File[ $kylin::install_dir ],
    }
  }

  file { $kylin::install_dir:
    ensure  => link,
    target  => $kylin::extract_dir,
    require => File[ $kylin::extract_dir ],
  }

  file { $kylin::config_dir:
    ensure  => directory,
    owner   => $kylin::kylin_user,
    group   => $kylin::group_user,
    require => [
      Group[ $kylin::kylin_group ],
      User[ $kylin::kylin_user ],
      Archive[ "${kylin::download_dir}/${kylin::basefilename}" ],
    ],
  }
}
