class rpmfusion(
    $free    = 1,
    $nonfree = 0
) {
    # RPMFusion requires EPEL to be installed
    include epel

    yumrepo { 'rpmfusion':
        mirrorlist  => "http://mirrors.rpmfusion.org/mirrorlist?repo=free-el-updates-released-${::os_maj_version}&arch=${::architecture}",
        enabled     => $free,
        gpgcheck    => 1,
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-el-6',
        descr       => 'RPM Fusion for EL 6 - Free - Updates'
    }

    yumrepo { 'rpmfusion-nonfree':
        mirrorlist  => "http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-el-updates-released-${::os_maj_version}&arch=${::architecture}",
        enabled     => $nonfree,
        gpgcheck    => 1,
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-el-6',
        descr       => 'RPM Fusion for EL 6 - Nonfree - Updates'
    }

    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-el-6':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/rpmfusion/RPM-GPG-KEY-rpmfusion-free-el-6',
    }

    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-el-6':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/rpmfusion/RPM-GPG-KEY-rpmfusion-nonfree-el-6',
    }

    epel::rpm_gpg_key{ 'rpmfusion-free':
        path => '/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-el-6',
    }

    if ($nonfree) {
        epel::rpm_gpg_key{ 'rpmfusion-nonfree':
            path => '/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-el-6',
        }
    }
}
