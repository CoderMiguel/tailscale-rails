require_relative "./configuration_helpers"

module Tailscale
  using Tailscale::Rails::Refinements::String::SnakeCase

  class Command < ::CLI::Binary
    include Tailscale::ConfigurationHelpers
  end
end
