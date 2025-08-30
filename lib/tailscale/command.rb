require_relative "./configuration_helpers"

module Tailscale
  using Tailscale::Rails::Refinements::String::SnakeCase

  class Command < ::CLI::Binary
    include Tailscale::ConfigurationHelpers

    class << self
      def handle_exit_status(error:, cli: nil, **options)
        # TODO: Raise an error if the wrong Error class is passed into this handler
        # super unless error.is_a? ::Terrapin::ExitStatusError

        cli.standard_error.squish.then do |error_message|
          case error_message
          when nil then super
          else
            block_given? ? yield(error_message) : super
          end
        end
      end
    end
  end
end
