require_relative "./binary.rb"

module CLI
  extend ActiveSupport::Autoload if defined?(Rails)

  class << self
    def eager_load!
      if defined?(Rails)
        autoload :Binary
      else
        # TODO: For non-Rails environments, load necessary files manually
        raise NotImplementedError, "CLI.eager_load! is only implemented for Rails environments"
      end
    end
  end
end
