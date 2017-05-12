class kylin::params {

  $version        = '1.6.0'
  $hbase_version  = '1.x'

  $mirror_url     = 'http://apache.rediris.es'
  $install_dir    = '/opt/kylin'
  $download_dir   = '/var/tmp/kylin'
  $log_dir        = '/opt/log'
  $pid_dir        = '/var/run/kylin'

  $kylin_user     = 'kylin'
  $kylin_uid      = undef
  $kylin_group    = 'kylin'
  $kylin_gid      = undef

  $package_name   = undef
  $package_ensure = installed

}
