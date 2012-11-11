class netbackup_poc::stage (
  $netbackup_installer = $netbackup_poc::params::installer,
  $netbackup_folder = $netbackup_poc::params::folder,
  $yes = $netbackup_poc::params::yes,
  $echo = $netbackup_poc::params::echo,
  $answer = $netbackup_poc::params::answer,
  $netbackup_server = $netbackup_poc::params::server,
  $nb_vers = $netbackup_poc::params::nb_vers
) inherits netbackup_poc::params {
  include staging

  file { 'staging_dir':
    ensure => directory,
    path   => '/tmp/staging',
    owner  => pe-puppet,
    group  => pe-puppet,
    before => Class['staging'],
  }
  
  staging::file { $netbackup_installer:
    source => "puppet:///files/netbackup/${netbackup_installer}"
  }

  staging::extract { $netbackup_installer:
    target  => '/tmp/staging',
    creates => "/tmp/staging/${netbackup_folder}",
    require => Staging::File[$netbackup_installer],
  }

  exec { 'install-netbackup':
    command => "${echo} ${answer} | /bin/sh /tmp/staging/${netbackup_folder}/NBClients/catalog/anb/client.inst",
    creates => "/usr/openv/regid.1992-12.com.symantec_netbackup-${nb_vers}.0.0_1.swidtag",
    require => Staging::Extract[$netbackup_installer],
  }
}
