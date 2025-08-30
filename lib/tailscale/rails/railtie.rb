require_relative "../rails.rb"
require_relative "../../cli/cli.rb"
require_relative "../../tailscale.rb"

module Tailscale
  module Rails
    class Railtie < ::Rails::Railtie
      [::CLI, Tailscale].each do |namespace|
        config.eager_load_namespaces << namespace
      end

      initializer "your_gem.configure_defaults" do |_app|
        ::Rails.application.config.eager_load = true
      #   Tailscale::Rails.configure do |config|
      #     config.restart_tailscale_daemon = true
      #   end
      end

      console do
        # Tailscale::Device.all_devices
        # Tailscale::Daemon.new
        # Maybe add helper methods to console

        at_exit { Tailscale.try(:down) }
      end

      # server do
      #   Tailscale::Daemon.new
      # end
    end
  end
end
