module Puppet::Parser::Functions
  newfunction(:require_param, :doc => <<-EOS
    Fails with message if parameter is not set.
    EOS
  ) do |args|

    raise(Puppet::ParseError, "set_real(): Wrong number of arguments " +
      "given (#{args.size} of 2 required)") if args.size != 2

    param = args[0]
    name  = args[1]

    if param.nil? or param == '' then
      fail("You must provide a value for the `#{name}` parameter!")
    end
  end
end
