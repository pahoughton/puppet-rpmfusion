# == Define: rpmfusion::repo
#
# This type is used to define the free and nonfree yum repositories for a
# specific rpmfusion repo.
#
# === Parameters
#
# [*repo*]
#
#   The type of repo to use (e.g. *updates-released* )
#   *Optional* (defaults to $name)
#
# [*free*]
#
#   Enables the repository containing free software.
#   *Optional* (defaults to 1)
#
# [*nonfree*]
#
#   Enables the repository containing nonfree software.
#   *Optional* (defaults to 0)
#
# [*architecture*]
#
#   Sets the architecture, this parameter is especially required if source
#   repositories shall be used in this case it should be set to *source*.
#   *Optional* (defaults to $::architecture)
#
# === Examples
#
#   rpmfusion::repo { '-': }
#
#   rpmfusion::repo { 'source':
#     nonfree      => '1',
#     architecture => 'source',
#   }
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
define rpmfusion::repo (
  $repo         = $name,
  $type,
  $version,
  $architecture = $::architecture
  ) {

  $repo_id = "${repo}-${type}-${version}"
  
  if "nonfree" in $repo {
    $gpg_path = "/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-${type}-${ver}"
  } else {
    $gpg_path = "/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-${type}-${ver}"
  }

  $mirrors = "http://mirrors.rpmfusion.org/mirrorlist?arch=${architecture}"

  yumrepo { "rpmfusion-${repo}":
    mirrorlist => "${mirrors}&repo=${repo_id}",
    enabled    => 1,
    gpgcheck   => 1,
    gpgkey     => "file://${gpg_path}",
    descr      => "RPM Fusion repo ${repo_id}",
  }
  
}
