require_relative "./flag/types/boolean"

module Tailscale
  class Command
    class TrueFlag < Flag::Types::Boolean
      # TODO: def initialize(name)
      #   super(name, value: true)
      # end
    end
  end
end
