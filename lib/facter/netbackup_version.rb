Facter.add("netbackup_version") do
  setcode do
    Facter::Util::Resolution.exec('/bin/cat /usr/openv/netbackup/bin/version')
  end
end
