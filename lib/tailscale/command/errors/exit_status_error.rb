module Tailscale
  class Command
    class ExitStatusError < Tailscale::Rails::Error
      # TODO: def initialize(error:)
      #   super
      #
      #   case error.message
      #   when /failed to connect to local tailscaled; it doesn't appear to be running/
      #     if Tailscale::Daemon.available?
      #       puts "Daemon is available but not running. Please start the Tailscale daemon."
      #       binding.pry
      #     else
      #       puts "Daemon is not available. Please install Tailscale."
      #       binding.pry
      #     end
      #   else
      #     raise error
      #   end
      # end
    end
  end
end
