# == Class: denyhosts::install
#
class denyhosts::install {
  if $denyhosts::package_name {
    package { 'denyhosts':
      ensure => $denyhosts::package_ensure,
      name   => $denyhosts::package_name,
    }
  }

  if $denyhosts::package_list {
    ensure_resource('package', $denyhosts::package_list, { 'ensure' => denyhosts::package_ensure })
  }
}
