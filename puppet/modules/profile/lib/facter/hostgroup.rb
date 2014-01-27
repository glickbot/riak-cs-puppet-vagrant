Facter.add("hostgroup") do
  setcode do
    Facter.value('hostname').sub(/-*\d+$/, '')
  end
end
