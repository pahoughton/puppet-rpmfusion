class rpmfusion (
  $free    = 1,
  $nonfree = 0,
  $with_version = true
  ) {
    # RPMFusion requires EPEL to be installed
    include epel
    include rpmfusion::params

    $gpg_path = '/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion'
    $gpg_module = 'puppet:///modules/rpmfusion/RPM-GPG-KEY-rpmfusion'
    $mirrors = "http://mirrors.rpmfusion.org/mirrorlist?arch=${::architecture}"
    $release_path = "${params::type}-updates-released-${params::version}"

    yumrepo { 'rpmfusion':
      mirrorlist => "${mirrors}&repo=free-${release_path}",
      enabled    => $free,
      gpgcheck   => 1,
      gpgkey     => "file://${gpg_path}-free-${params::type}-${params::version}",
      descr      => 'RPM Fusion for EL 6 - Free - Updates'
    }

    yumrepo { 'rpmfusion-nonfree':
      mirrorlist => "${mirrors}&repo=nonfree-${release_path}",
      enabled    => $nonfree,
      gpgcheck   => 1,
      gpgkey     => "file://${gpg_path}-nonfree-${params::type}-${params::version}",
      descr      => 'RPM Fusion for EL 6 - Nonfree - Updates'
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
