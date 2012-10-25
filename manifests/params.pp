class netbackup_poc::params{

  $server = "master"
  $answer = "\"y\n${server}\ny\""

  case $architecture {
    "i86pc", "i386" : {
      $folder = "NetBackup_6.5_CLIENTS"
    }
    "x86_64", "sun4u" : {
      $folder = "NetBackup_7.5_CLIENTS"
    }
  }

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
