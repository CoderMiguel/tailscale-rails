module Tailscale
  module Rails
    class Error < StandardError
      include Tailscale::Rails::Logging

      def initialize(error:)
        log_error(error:)
      end
    end
  end
end
