module Tailscale
  class Command
    class CommandNotFoundError < Tailscale::Rails::Error
      # TODO: def initialize(error:)
      #   super
      #   binding.pry
      # end
    end
  end
end
