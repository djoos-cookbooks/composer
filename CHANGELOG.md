# composer cookbook CHANGELOG

This file is used to list changes made in each version (>= 2.4.0) of the composer cookbook.

## 3.0.1 (2022-03-25)

- Fix for install_dir method callout, which should be composer_install_dir since 3.0.0 (NoMethodError: undefined method `install_dir` for Chef::Resource::Execute)

## 3.0.0 (2022-03-08)

- Remove unneeded dependencies on `apt` / `windows` cookbooks for resources now in core Chef
- Adds testing on Alma / Rocky Linux 8
- Remove dependency on `php` cookbook
  - ⚠ This cookbook will no longer install PHP for you!
  - Use e.g. the `php` cookbook directly to install PHP before including these recipes

## 2.8.0 (2021-12-15)

- Chef 17 compatibility: enable `unified_mode` for custom resources
- Remove deprecated foodcritic tool
- Apply Cookstyle fixes
- Convert legacy LWRP structure to custom resource syntax
- Update Kitchen config to Inspec and current platforms
- Update Travis CI to latest Chef Workstation

## 2.7.0 (2020-04-29)

- Point to new endpoint for stable download

## 2.6.1 (2017-06-22)

- Fixed correct default for environment attribute: Hash instead of nil

## 2.6.0 (2017-04-13)

- Fix Travis tests
- Allow passing environment variables to composer_project

## 2.5.2 (2016-11-30)

- Fix artifact on supermarket

## 2.5.1 (2016-11-11)

- Fix bug in composer_project with empty return

## 2.5.0 (2016-11-03)

- Add composer_global_install to install composer packages globally

## 2.4.0 (2016-08-24)

- Refactored the cookbook
