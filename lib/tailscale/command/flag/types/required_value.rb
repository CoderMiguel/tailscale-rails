require_relative "../../flag"

module Tailscale
  using Tailscale::Rails::Refinements::String::SnakeCase

  class Command
    module Flag
      module Types

        class RequiredValue
          include Flag

          def initialize(name:, value: nil)
            super(name:, type: , value:)
          end

          private

          def type
            self.class.name.demodulize.snake_case.to_sym
          end
        end
      end
    end
  end
end
