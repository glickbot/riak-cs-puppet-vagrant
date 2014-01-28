module Puppet::Parser::Functions
  newfunction(:member_of_key, :type => :rvalue, :doc => <<-EOS
    Returns key of item where { "key" => [ item, ... ], ... }
    EOS
  ) do |args|
    raise(Puppet::ParseError, "set_real(): Wrong number of arguments " +
      "given (#{args.size} of 2 required)") if args.size != 2
    hoa  = args[0]
    member = args[1]
    return hoa.select { |k,a| a.select { |v| v.casecmp(member) == 0 }.length > 0 }.keys
  end
end