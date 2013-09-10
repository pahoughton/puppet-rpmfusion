Puppet RPM Fusion repo module
==============

Adds the RPM Fusion repo. Tested on CentOS 6.

Usage
--------------

```puppet
include rpmfusion
```

This will enable the free repo. To enable the nonfree repo:

```puppet
class {'rpmfusion':
	nonfree => 1,
}
```

Dependencies
--------------
* [puppet-module-epel](https://github.com/stahnma/puppet-module-epel)
