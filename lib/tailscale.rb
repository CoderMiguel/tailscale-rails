require_relative "./tailscale/rails"

module Tailscale
  include Tailscale::Rails if defined?(::Rails)

  delegate(*%i[as_json], to: :Status, prefix: :status)
  alias status status_as_json
  module_function :status

  module_function

  def devices
    Tailscale::Device.all_devices
  end

  def down
    Down.new.success?
  end

  def eager_load!
    if included_modules.include? Tailscale::Rails
      Tailscale::Rails.eager_load!
    else
      # TODO: For non-Rails environments, load necessary files manually
      raise NotImplementedError, "Tailscale.eager_load! is only implemented for Rails environments"
    end
  end

  def up
    Up.new if Status.needs_login? || Status.stopped?
  end

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
