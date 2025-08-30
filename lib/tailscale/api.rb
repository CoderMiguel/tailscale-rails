module Tailscale
  class API
    module_function

    def devices
      # binding.pry
      # curl 'https://api.tailscale.com/api/v2/tailnet/{tailnet}/devices' \
      #      --header 'Authorization: Bearer YOUR_SECRET_TOKEN'
    end
  end
end
