require_relative "./tailscale/rails"

module Tailscale
  include Tailscale::Rails if defined?(::Rails)

  class << self
    def eager_load!
      if included_modules.include? Tailscale::Rails
        Tailscale::Rails.eager_load!
      else
        # TODO: For non-Rails environments, load necessary files manually
        raise NotImplementedError
      end
    end
  end
  #   # def status
  #   #   Status.new
  #   # end
  #
  #   # def up
  #   #   Up.new if Status.needs_login?
  #   # end
  #
  #   # delegate(*%i[running?], to: Status)
  #
  #   # def marco
  #   #   :polo
  #   # end
  #   #
  #   # def status
  #   #   Tailscale::Status.as_json
  #   # rescue StandardError => e
  #   #   # TODO: check for tailscale being installed
  #   #   #   Raise the appropriate error for the Tailscale specific error
  #   #   #   else
  #   #   #   Raise the appropriate error if tailscale is not installed
  #   # end
  # end

#     # def device(device_name)
#     #   Tailscale::Device.find_by_name(device_name)
#     # end
#     #
#     # def devices
#     #   Tailscale::Device.all_devices
#     # end
#     #
#     # def device_count
#     #   devices.count
#     # end
#     #
#     # def device_names
#     #   devices.map(&:name)
#     # end
#     #
#     # def device_ips
#     #   devices.map(&:ip)
#     # end
#   end
end
