# == Class: denyhosts::params
#
class denyhosts::params {
  $package_name = $::osfamily ? {
    default => 'denyhosts',
  }

  $package_list = $::osfamily ? {
    default => undef,
  }

  $config_dir_path = $::osfamily ? {
    default => '/etc',
  }

  $config_file_path = $::osfamily ? {
    default => '/etc/denyhosts.conf',
  }

  $config_file_owner = $::osfamily ? {
    default => 'root',
  }

  $config_file_group = $::osfamily ? {
    default => 'root',
  }

  $config_file_mode = $::osfamily ? {
    default => '0640',
  }

  $config_file_notify = $::osfamily ? {
    default => 'Service[denyhosts]',
  }

  $config_file_require = $::osfamily ? {
    default => 'Package[denyhosts]',
  }

  $service_name = $::osfamily ? {
    default => 'denyhosts',
  }

  case $::osfamily {
    'Debian': {
      if getvar('::lsbdistcodename') == 'trusty' {
        fail("${::lsbdistid} ${::lsbdistrelease} not supported.")
      }
    }
    default: {
      fail("${::operatingsystem} not supported.")
    }
  }
}
