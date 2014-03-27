# == Class: rpmfusion
#
# This module configures the rpmfusion yum repository on Fedora/CentOS/RHEL.
#
# === Parameters
#
# [*free*]
#
#   If this parameter is set to 1, the free repository for free software will be
#   enabled, if set to 2 not
#   *Optional* (defaults to 1)
#
# [*nonfree*]
#
#   If this parameter is set to 1, the free repository for free software will be
#   enabled, if set to 0 not
#   *Optional* (defaults to 0)
#
# [*with_version*]
#
#   If this parameter is set to true the repository with the actual operating
#   systems version is used, if it is set to false the repository without
#   operating system is used.
#   *Optional* (defaults to true)
#
# [*repos*]
#
#   This parameter defines which rpmfusion repositories to configure. Multiple
#   repositories can be set up by specifying them as list. Possible values can
#   be seen in the rpfusion::params class file.
#   *Optional* (defaults to [ 'updates-released' ])
#
# === Variables
#
# === Examples
#
#  include rpmfusion
#
#  class { 'rpmfusion':
#    nonfree => 1,
#    repos   => [ '-', 'debug', 'updates-released', 'updates-testing' ]
#  }
#
# === Authors
#
# Lee Boynton <lee@lboynton.com>
# Marcellus Siegburg <msiegbur@imn.htwk-leipzig.de>
#
# === Copyright
#
# Copyright 2013 Lee Boynton, Marcellus Siegburg
#
class rpmfusion (
  $repos        = [ 'free',
                    'free-updates-released',
                    'nonfree',
                    'nonfree-updates-released', ],
  ) {
  # also available:
  #   debug source updates-released-debug
  #   updates-testing update-testing-debug

  # RPMFusion requires EPEL to be installed
  class { 'epel' : }

  if $::osfamily == 'RedHat' {
    case $::operatingsystem {
      'Fedora': {
        $type = 'fedora'
        $version = $::operatingsystemrelease ? {
          /(?i-mx:1[1-9]|2[0-1])/ => $::operatingsystemrelease,
          default => undef,
        }
      }
      default : {
        $type = 'el'
        $version = $::os_maj_version
      }
    }
  } else {
    fail("Only ::osfamily RedHat supported '${::osfmily}'")
  }
  if ! $version {
    # limited by my available gpg keys in ../files
    fail("Unspported  \$::operatingsystem-\$::os_maj_version ${::operatingsystem}-${::os_maj_version}")
  }

  $gpg_path = '/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion'
  $gpg_module = 'puppet:///modules/rpmfusion/RPM-GPG-KEY-rpmfusion'

  if 'nonfree' in $repos {
    file { "${gpg_path}-nonfree-${type}-${version}":
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => "${gpg_module}-nonfree-${type}-${version}",
    }
    epel::rpm_gpg_key { 'rpmfusion-nonfree':
      path => "${gpg_path}-nonfree-${type}-${version}",
    }
  }

  file { "${gpg_path}-free-${type}-${version}":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "${gpg_module}-free-${type}-${version}",
  }

  epel::rpm_gpg_key { 'rpmfusion-free':
    path => "${gpg_path}-free-${type}-${version}",
  }

  rpmfusion::repo { $repos :
    type    => $type,
    version => $version,
  }
}
