module Tailscale
  module Rails
    module Refinements
      module String
        module SnakeCase
          refine ::String do
            def snake_case
              underscore.parameterize(separator: "_")
            end
          end
        end
      end
    end
  end
end
