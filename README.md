Puppet RPM Fusion repo module
==============

Adds the RPM Fusion repo. Tested on CentOS 6 and Fedora 19.

Usage
--------------

```puppet
include rpmfusion
```

This will enable the free repo for updates-released. To enable the nonfree repo:

```puppet
class { 'rpmfusion':
  nonfree => 1,
}
```

To enable other repos specify them in an array.

```puppet
class { 'rpmfusion':
  repo    => [ '-', 'updates-released', 'updates-testing' ],
  nonfree => 1,
}
```

Dependencies
--------------

* [puppet-module-epel](https://github.com/stahnma/puppet-module-epel)
