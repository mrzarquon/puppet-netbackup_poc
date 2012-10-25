# Class: NetBackup
# Ensures netbackup for a specific version is present
class netbackup_poc (
  $netbackup_installer = $netbackup_poc::params::installer,
  $netbackup_folder = $netbackup_poc::params::folder,
  $tar = $netbackup_poc::params::tar,
  $yes = $netbackup_poc::params::yes,
  $echo = $netbackup_poc::params::echo,
  $answer = $netbackup_poc::params::answer,
  $netbackup_server = $netbackup_poc::params::server,
) inherits netbackup_poc::params {
  
  file { "/var/tmp/${netbackup_installer}":
    ensure   => file,
    source   => "puppet:///files/netbackup/${netbackup_installer}",
  }

  exec { 'unpack-netbackup-installer':
    command => "$tar -x -f /var/tmp/${netbackup_installer}",
    cwd     => "/var/tmp",
    creates => "/var/tmp/${netbackup_folder}/install",
    require => File["/var/tmp/${netbackup_installer}"],
    notify  => Exec["install-netbackup"],
  }

  exec { 'install-netbackup':
    command     => "${echo} ${answer} | /bin/sh /var/tmp/${netbackup_folder}/NBClients/catalog/anb/client.inst",
    refreshonly => "true",
    require    => Exec['unpack-netbackup-installer'],
  }
}
