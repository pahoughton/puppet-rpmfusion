class rpmfusion (
  $free         = 1,
  $nonfree      = 0,
  $with_version = true,
  $repos        = ['updates-released']
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
