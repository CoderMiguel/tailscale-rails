module Tailscale
  module Status
    class << self
      def as_json
        JSON.parse(`tailscale status --json`)
      end
    end
  end
end
