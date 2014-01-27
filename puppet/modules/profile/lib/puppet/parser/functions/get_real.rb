module Puppet::Parser::Functions
  newfunction(:get_real, :type => :rvalue, :doc => <<-EOS
    Returns default value if first argument is undef.
    EOS
  ) do |args|

    raise(Puppet::ParseError, "set_real(): Wrong number of arguments " +
      "given (#{args.size} of 2 required)") if args.size != 2

    result  = args[0]
    default = args[1]
    if result.nil? or result == '' then
      return default
    else
      return result
    end
  end
end
