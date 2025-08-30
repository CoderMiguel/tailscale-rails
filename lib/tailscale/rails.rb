# frozen_string_literal: true

if defined?(Rails)
  require "terrapin"

  require_relative "./rails/refinements/string/snake_case"
  require_relative "./rails/railtie"
  require_relative "./command"
  require_relative "./commands/down"
  require_relative "./commands/status"
  require_relative "./commands/up"

  # TODO: build a generator to install the Tailscale binary

  module Tailscale
    module Rails
      # extend ActiveSupport::Concern
      extend ActiveSupport::Autoload

      attr_reader(*%i[configuration])
      module_function :configuration

      module_function

      def eager_load!
        @configuration = Tailscale::Configuration.new
        autoload :Down
        autoload :Status
        autoload :Up
        # ConfigurationHelpers.eager_load!
        # Configuration.eager_load!
      end
    end
  end
end
