# Author::    Liam Bennett  (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: kafka::broker::service
#
# This private class is meant to be called from `kafka::broker`.
# It manages the kafka service
#
class kafka::broker::service (
  $kafka_heap_opts = $kafka::broker::kafka_heap_opts,
  $manage_service  = $kafka::broker::manage_service
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { '/etc/init.d/kafka':
    ensure  => present,
    mode    => '0755',
    content => template('kafka/init.erb')
  }

  if $manage_service == true {
    service { 'kafka':
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
      require    => File['/etc/init.d/kafka']
    }
  }

}
