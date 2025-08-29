module Tailscale
  class Configuration
    include ActiveModel::Attributes

    BOOLEAN_ATTRIBUTES = %i[restart_tailscale_daemon].freeze
    ATTRIBUTES = %i[auth_key hostname].tap { |array| array.concat(BOOLEAN_ATTRIBUTES) } .freeze
    constants(false).each { |constant| private_constant constant }

    attribute :auth_key, :string, default: ENV["TAILSCALE_AUTH_KEY"]
    attribute :restart_tailscale_daemon, :boolean, default: false
    attr_reader(*%i[restart_tailscale_daemon])

    attribute_method_suffix '?'
    define_attribute_methods :restart_tailscale_daemon

    def initialize
      @restart_tailscale_daemon = true
      super
    end

    private

    def attribute?(attr_name)
      send(attr_name) == true
    end

    # def validate!
    #   # raise ArgumentError, "redis_url cannot be blank" if redis_url.blank?
    #   # Add other validations as needed
    # end
  end
end
