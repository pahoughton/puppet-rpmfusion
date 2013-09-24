define rpmfusion::repo (
  $repo         = $name,
  $free         = 1,
  $nonfree      = 0,
  $architecture = $::architecture
  ) {
    include rpmfusion::params

    if $repo in $params::repos {
      if $repo in $params::source_repos {
        if $architecture != 'source' {
          fail ("Repository type '${repo}' only available for arch source")
        }
      }
    } else {
      fail ("Repository type '${repo}' not supported")
    }
    $repository = $repo ? {
      '-'     => '',
      default => "${repo}-"
    }

    $gpg_path = '/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion'
    $mirrors = "http://mirrors.rpmfusion.org/mirrorlist?arch=${architecture}"
    $release_path = "${params::type}-${repository}${params::version}"

    yumrepo { "rpmfusion-${repo}":
      mirrorlist => "${mirrors}&repo=free-${release_path}",
      enabled    => $free,
      gpgcheck   => 1,
      gpgkey     => "file://${gpg_path}-free-${params::type}-${params::version}",
      descr      => "RPM Fusion for EL 6 - Free - ${repo}"
    }

    yumrepo { "rpmfusion-nonfree-${repo}":
      mirrorlist => "${mirrors}&repo=nonfree-${release_path}",
      enabled    => $nonfree,
      gpgcheck   => 1,
      gpgkey     => "file://${gpg_path}-nonfree-${params::type}-${params::version}",
      descr      => "RPM Fusion for EL 6 - Nonfree - ${repo}"
    }
}
