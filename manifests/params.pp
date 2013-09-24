class rpmfusion::params {
  $source_repos =
    [ 'source', 'updates-released-source', 'updates-testing-source' ]
  $repos =
    [ '-', 'debug', 'updates-released', 'updates-released-debug',
      'updates-testing', 'updates-testing-debug', $source_repos ]
  if $::osfamily == 'RedHat' {
    case $::operatingsystem {
      'Fedora': {
        $supported_gpg = ['',11,12,13,14,15,16,17,18,19,21]
        $type = 'fedora'
        if $rpmfusion::with_version == true {
          $version = $::operatingsystemrelease
        } else {
          $version = ''
        }
      }
      default: {
        $supported_gpg = ['',6]
        $type = 'el'
        if $rpmfusion::with_version == true {
          $version = $::os_may_version
        } else {
          $version = ''
        }
      }
    }
  } else {
    fail("Operating system family ${::osfamily} not supported")
  }

  if $version in $supported_gpg {
  } else {
    fail("No GPG for $::{operatingsystem} ${version}.x found")
  }
}
