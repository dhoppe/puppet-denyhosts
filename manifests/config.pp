# == Class: denyhosts::config
#
class denyhosts::config {
  if $::denyhosts::config_dir_source {
    file { 'denyhosts.dir':
      ensure  => $::denyhosts::config_dir_ensure,
      path    => $::denyhosts::config_dir_path,
      force   => $::denyhosts::config_dir_purge,
      purge   => $::denyhosts::config_dir_purge,
      recurse => $::denyhosts::config_dir_recurse,
      source  => $::denyhosts::config_dir_source,
      notify  => $::denyhosts::config_file_notify,
      require => $::denyhosts::config_file_require,
    }
  }

  if $::denyhosts::config_file_path {
    file { 'denyhosts.conf':
      ensure  => $::denyhosts::config_file_ensure,
      path    => $::denyhosts::config_file_path,
      owner   => $::denyhosts::config_file_owner,
      group   => $::denyhosts::config_file_group,
      mode    => $::denyhosts::config_file_mode,
      source  => $::denyhosts::config_file_source,
      content => $::denyhosts::config_file_content,
      notify  => $::denyhosts::config_file_notify,
      require => $::denyhosts::config_file_require,
    }
  }
}
