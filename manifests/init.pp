# == Class: tomcat
#
# Full description of class tomcat here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { tomcat:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class tomcat (
  $catalina_home = $::tomcat::params::catalina_home,
  $user          = $::tomcat::params::user,
  $group         = $::tomcat::params::group,
  $manage_user   = true,
  $manage_group  = true,
) inherits ::tomcat::params {
  validate_bool($manage_user)
  validate_bool($manage_group)

  case $::osfamily {
    'windows': {
      fail("Unsupported osfamily: ${osfamily}")
    }
    default: { }
  }

  file { $catalina_home:
    ensure => directory,
    owner  => $user,
    group  => $group,
  }

  if $manage_user {
    user { $user:
      ensure => present,
      gid    => $group
    }
  }

  if $manage_group {
    group { $group:
      ensure => present,
    }
  }
}