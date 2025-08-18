module Tailscale
  class << self
    def status
      Tailscale::Status.as_json
    rescue StandardError => e
      # TODO: check for tailscale being installed
      #   Raise the appropriate error for the Tailscale specific error
      #   else
      #   Raise the appropriate error if tailscale is not installed
    end

    # def device(device_name)
    #   Tailscale::Device.find_by_name(device_name)
    # end
    #
    # def devices
    #   Tailscale::Device.all_devices
    # end
    #
    # def device_count
    #   devices.count
    # end
    #
    # def device_names
    #   devices.map(&:name)
    # end
    #
    # def device_ips
    #   devices.map(&:ip)
    # end
  end
end
