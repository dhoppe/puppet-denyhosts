# == Class: denyhosts::service
#
class denyhosts::service {
  if $denyhosts::service_name {
    service { 'denyhosts':
      ensure => $denyhosts::_service_ensure,
      name   => $denyhosts::service_name,
      enable => $denyhosts::_service_enable,
    }

    if getvar('::lsbdistcodename') == 'squeeze' {
      Service['denyhosts'] {
        hasstatus => false,
      }
    }
  }
}
