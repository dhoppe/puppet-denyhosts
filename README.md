# denyhosts

[![Build Status](https://travis-ci.org/dhoppe/puppet-denyhosts.png?branch=master)](https://travis-ci.org/dhoppe/puppet-denyhosts)
[![Code Coverage](https://coveralls.io/repos/github/dhoppe/puppet-denyhosts/badge.svg?branch=master)](https://coveralls.io/github/dhoppe/puppet-denyhosts)
[![Puppet Forge](https://img.shields.io/puppetforge/v/dhoppe/denyhosts.svg)](https://forge.puppetlabs.com/dhoppe/denyhosts)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/dhoppe/denyhosts.svg)](https://forge.puppetlabs.com/dhoppe/denyhosts)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/dhoppe/denyhosts.svg)](https://forge.puppetlabs.com/dhoppe/denyhosts)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/dhoppe/denyhosts.svg)](https://forge.puppetlabs.com/dhoppe/denyhosts)

#### Table of Contents

1. [Overview](#overview)
1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics of getting started with denyhosts](#setup)
    * [What denyhosts affects](#what-denyhosts-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with denyhosts](#beginning-with-denyhosts)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Overview

This module installs, configures and manages the Denyhosts service.

## Module Description

This module handles installing, configuring and running Denyhosts across a range
of operating systems and distributions.

## Setup

### What denyhosts affects

* denyhosts package.
* denyhosts configuration file.
* denyhosts service.

### Setup Requirements

* Puppet >= 3.0
* Facter >= 1.6
* [Stdlib module](https://github.com/puppetlabs/puppetlabs-stdlib)

### Beginning with denyhosts

Install denyhosts with the default parameters ***(No configuration files will be
changed)***.

```puppet
    class { 'denyhosts': }
```

Install denyhosts with the recommended parameters.

```puppet
    class { 'denyhosts':
      config_file_template => 'denyhosts/common/etc/denyhosts.conf.erb',
      config_file_hash     => {
        'allowed-hosts' => {
          config_file_path     => '/var/lib/denyhosts/allowed-hosts',
          config_file_mode     => '0644',
          config_file_template => 'denyhosts/common/var/lib/denyhosts/allowed-hosts.erb',
        },
      },
    }
```

## Usage

Update the denyhosts package.

```puppet
    class { 'denyhosts':
      package_ensure => 'latest',
    }
```

Remove the denyhosts package.

```puppet
    class { 'denyhosts':
      package_ensure => 'absent',
    }
```

Purge the denyhosts package ***(All configuration files will be removed)***.

```puppet
    class { 'denyhosts':
      package_ensure => 'purged',
    }
```

Deploy the configuration files from source directory.

```puppet
    class { 'denyhosts':
      config_dir_source => 'puppet:///modules/denyhosts/common/etc',
    }
```

Deploy the configuration files from source directory ***(Unmanaged configuration
files will be removed)***.

```puppet
    class { 'denyhosts':
      config_dir_purge  => true,
      config_dir_source => 'puppet:///modules/denyhosts/common/etc',
    }
```

Deploy the configuration file from source.

```puppet
    class { 'denyhosts':
      config_file_source => 'puppet:///modules/denyhosts/common/etc/denyhosts.conf',
    }
```

Deploy the configuration file from string.

```puppet
    class { 'denyhosts':
      config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
    }
```

Deploy the configuration file from template.

```puppet
    class { 'denyhosts':
      config_file_template => 'denyhosts/common/etc/denyhosts.conf.erb',
    }
```

Deploy the configuration file from custom template ***(Additional parameters can
be defined)***.

```puppet
    class { 'denyhosts':
      config_file_template     => 'denyhosts/common/etc/denyhosts.conf.erb',
      config_file_options_hash => {
        'key' => 'value',
      },
    }
```

Deploy additional configuration files from source, string or template.

```puppet
    class { 'denyhosts':
      config_file_hash => {
        'denyhosts.2nd.conf' => {
          config_file_path   => '/etc/denyhosts.2nd.conf',
          config_file_source => 'puppet:///modules/denyhosts/common/etc/denyhosts.2nd.conf',
        },
        'denyhosts.3rd.conf' => {
          config_file_path   => '/etc/denyhosts.3rd.conf',
          config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
        },
        'denyhosts.4th.conf' => {
          config_file_path     => '/etc/denyhosts.4th.conf',
          config_file_template => 'denyhosts/common/etc/denyhosts.4th.conf.erb',
        },
      },
    }
```

Disable the denyhosts service.

```puppet
    class { 'denyhosts':
      service_ensure => 'stopped',
    }
```

## Reference

### Classes

#### Public Classes

* denyhosts: Main class, includes all other classes.

#### Private Classes

* denyhosts::install: Handles the packages.
* denyhosts::config: Handles the configuration file.
* denyhosts::service: Handles the service.

### Parameters

#### `package_ensure`

Determines if the package should be installed. Valid values are 'present',
'latest', 'absent' and 'purged'. Defaults to 'present'.

#### `package_name`

Determines the name of package to manage. Defaults to 'denyhosts'.

#### `package_list`

Determines if additional packages should be managed. Defaults to 'undef'.

#### `config_dir_ensure`

Determines if the configuration directory should be present. Valid values are
'absent' and 'directory'. Defaults to 'directory'.

#### `config_dir_path`

Determines if the configuration directory should be managed. Defaults to '/etc'

#### `config_dir_purge`

Determines if unmanaged configuration files should be removed. Valid values are
'true' and 'false'. Defaults to 'false'.

#### `config_dir_recurse`

Determines if the configuration directory should be recursively managed. Valid
values are 'true' and 'false'. Defaults to 'true'.

#### `config_dir_source`

Determines the source of a configuration directory. Defaults to 'undef'.

#### `config_file_ensure`

Determines if the configuration file should be present. Valid values are 'absent'
and 'present'. Defaults to 'present'.

#### `config_file_path`

Determines if the configuration file should be managed. Defaults to '/etc/denyhosts.conf'

#### `config_file_owner`

Determines which user should own the configuration file. Defaults to 'root'.

#### `config_file_group`

Determines which group should own the configuration file. Defaults to 'root'.

#### `config_file_mode`

Determines the desired permissions mode of the configuration file. Defaults to '0640'.

#### `config_file_source`

Determines the source of a configuration file. Defaults to 'undef'.

#### `config_file_string`

Determines the content of a configuration file. Defaults to 'undef'.

#### `config_file_template`

Determines the content of a configuration file. Defaults to 'undef'.

#### `config_file_notify`

Determines if the service should be restarted after configuration changes.
Defaults to 'Service[denyhosts]'.

#### `config_file_require`

Determines which package a configuration file depends on. Defaults to 'Package[denyhosts]'.

#### `config_file_hash`

Determines which configuration files should be managed via `denyhosts::define`.
Defaults to '{}'.

#### `config_file_options_hash`

Determines which parameters should be passed to an ERB template. Defaults to '{}'.

#### `service_ensure`

Determines if the service should be running or not. Valid values are 'running'
and 'stopped'. Defaults to 'running'.

#### `service_name`

Determines the name of service to manage. Defaults to 'denyhosts'.

#### `service_enable`

Determines if the service should be enabled at boot. Valid values are 'true' and
'false'. Defaults to 'true'.

#### `email`

Determines which email address (recipient) should be notified about restricted
hosts and suspicious logins. Defaults to "denyhosts@${::domain}".

#### `email_from`

Determines which email address (sender) should be used. Defaults to "root@${::fqdn}".

#### `email_subject`

Determines which email subject should be used. Defaults to "[denyhosts] Report
from ${::fqdn}".

#### `deny_threshold_invalid`

Determines the number of failed login attempts (invalid user) needed to block a
host. Defaults to '3'.

#### `deny_threshold_valid`

Determines the number of failed login attempts (valid user) needed to block a
host. Defaults to '3'.

#### `purge_deny`

Determines after how many days entries will be purged. Defaults to '5d'.

#### `whitelist`

Determines which ip addresses will not be reported. Defaults to '['127.0.0.1', '192.168.56.*']'.

## Limitations

This module has been tested on:

* Debian 6/7
* Ubuntu 12.04

## Development

### Bug Report

If you find a bug, have trouble following the documentation or have a question
about this module - please create an issue.

### Pull Request

If you are able to patch the bug or add the feature yourself - please make a
pull request.

### Contributors

The list of contributors can be found at: [https://github.com/dhoppe/puppet-denyhosts/graphs/contributors](https://github.com/dhoppe/puppet-denyhosts/graphs/contributors)
