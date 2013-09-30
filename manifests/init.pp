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
  $free         = 1,
  $nonfree      = 0,
  $with_version = true,
  $repos        = [ 'updates-released' ]
  ) {
    # RPMFusion requires EPEL to be installed
    include epel
    include rpmfusion::params

    $gpg_path = '/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion'
    $gpg_module = 'puppet:///modules/rpmfusion/RPM-GPG-KEY-rpmfusion'

    rpmfusion::repo { $repos:
      free    => $free,
      nonfree => $nonfree,
    }

    file { "${gpg_path}-free-${params::type}-${params::version}":
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => "${gpg_module}-free-${params::type}-${params::version}",
    }

    file { "${gpg_path}-nonfree-${params::type}-${params::version}":
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => "${gpg_module}-nonfree-${params::type}-${params::version}",
    }

    epel::rpm_gpg_key { 'rpmfusion-free':
      path => "${gpg_path}-free-${params::type}-${params::version}",
    }

    if ($nonfree) {
      epel::rpm_gpg_key { 'rpmfusion-nonfree':
        path => "${gpg_path}-nonfree-${params::type}-${params::version}",
      }
    }
}
