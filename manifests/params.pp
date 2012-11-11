class netbackup_poc::params{

  $server = "master"
  $answer = "\"y\n${server}\ny\""

  case $architecture {
    "i86pc", "i386" : {
      $nb_vers = "6.5"
    }
    "x86_64", "sun4u" : {
      $nb_vers = "7.5"
    }
  }

  $folder = "NetBackup_${nb_vers}_CLIENTS"
  $installer = "${folder}_.tar.gz"

  case $osfamily {
    redhat : { 
      $yes = "/usr/bin/yes"
      $tar = "/bin/tar"
      $echo = "/bin/echo"
    }
    solaris : {
      $yes = "/usr/bin/yes"
      $tar = "/usr/sbin/yes"
    }
  }
}
