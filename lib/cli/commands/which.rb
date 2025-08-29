require_relative "../binary"

module CLI
  class Which < Binary
    class << self
      alias binary subcommand
    end
  end
end
