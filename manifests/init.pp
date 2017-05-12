# Class: kylin
# ===========================
#
# Full description of class kylin here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'kylin':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class kylin (

  $version               = $kylin::params::version,
  $hbase_version         = $kylin::params::hbase_version,

  $install_dir           = $kylin::params::install_dir,
  $extract_dir           = "/opt/kylin-${version}",
  $download_dir          = $kylin::params::download_dir,
  $mirror_url            = $kylin::params::mirror_url,
  $basefilename          = "apache-kylin-${version}-hbase${hbase_version}-bin.tar.gz",
  $package_url           = "${mirror_url}/kylin/apache-kylin-${version}/${basefilename}",
  $log_dir               = $kylin::params::log_dir,
  $pid_dir               = $kylin::params::pid_dir,
  $config_dir            = "${install_dir}/conf",

  $kylin_group           = $kylin::params::kylin_group,
  $kylin_gid             = $kylin::params::kylin_gid,
  $kylin_user            = $kylin::params::kylin_user,
  $kylin_uid             = $kylin::params::kylin_uid,

  $package_name   = $kylin::params::package_name,
  $package_ensure = $kylin::params::package_ensure,

) inherits kylin::params {

  group { $kylin_group:
    ensure => present,
    gid    => $kylin_gid,
  }

  user { $kylin_user:
    ensure  => present,
    uid     => $kylin_uid,
    groups  => $kylin_group,
    require => Group[ $kylin_group ],
  }

  anchor { '::kylin::start': } ->
  class { '::kylin::install': } ->
  anchor { '::kylin::end': }

}
