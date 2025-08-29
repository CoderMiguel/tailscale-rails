require_relative "./flag/types/boolean"

module Tailscale
  class Command
    class FalseFlag < Flag::Types::Boolean
      # TODO: def initialize(name)
      #   # @default_value = false
      #   super(name, value: false)
      # end
      #
      # def select
      #   super
      #
      #   binding.pry
      #   # becomes(TrueFlag)
      # end
    end
  end
end
