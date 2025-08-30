module Tailscale
  class Device
    class << self
      # include Tailscale

      def all_devices
        status["Peer"].map { |(node_key, json)| new(json:, node_key:) }
      end

      private

      delegate(*%i[status], to: :Tailscale)
    end

    def initialize(*args, **options)
    #   # binding.pry
    #   puts(**options)
    #   # TODO: initialize Tailscale::Device objects
    #   # TODO: investigate appending API device data
    end
  end
end
