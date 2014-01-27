Facter.add("zone") do
  setcode do
    # second value in a fqdn is the zone, by convention
    # dns1.zion.tfoundry.com has a zone of 'zion'
    Facter.value('fqdn').split(".")[1]
  end
end
