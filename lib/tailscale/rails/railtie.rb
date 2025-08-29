require_relative "../rails.rb"
require_relative "../../tailscale.rb"

module Tailscale
  module Rails
    class Railtie < ::Rails::Railtie
      # TODO: config.eager_load_namespaces << Tailscale

      initializer "your_gem.configure_defaults" do |_app|
        ::Rails.application.config.eager_load = true
      #   Tailscale::Rails.configure do |config|
      #     config.restart_tailscale_daemon = true
      #   end
      end

      console do
        # Tailscale::Daemon.new
        # Maybe add helper methods to console
      end

      # server do
      #   Tailscale::Daemon.new
      # end
    end
  end
end
