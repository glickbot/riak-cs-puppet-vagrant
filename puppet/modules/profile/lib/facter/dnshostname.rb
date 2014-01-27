#Facter.add("dnshostname") do
#  setcode do
#    require 'resolv'
#    Resolv.getname(Facter.value('ipaddress_eth0')).split('.')[0]
#  end
#end
