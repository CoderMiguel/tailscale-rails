require_relative './required_value'

module Tailscale
  class Command
    module Flag
      module Types
        class Boolean < RequiredValue
          def initialize(name:, value: true)
            super(name:, value:)
          end

          def to_s(format: :long, with_value: false)
            super
          end
        end
      end
    end
  end
end
