require_relative "./rails/configuration_helpers" if defined?(Rails)

module Tailscale
  module ConfigurationHelpers
    class << self
      def included(base)
        class << base
          if defined?(Rails)
            include Tailscale::Rails::ConfigurationHelpers
          # else
          end
          delegate(*%i[restart_tailscale_daemon?], to: :configuration)
        end
      end
    end
  end
end
