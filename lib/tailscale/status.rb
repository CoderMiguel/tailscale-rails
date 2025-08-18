module Tailscale
  module Status
    class << self
      def as_json
        JSON.parse(`tailscale status --json`)
      end

      def status_attribute
        as_json[__callee__.classify]
      end
      alias backend_state status_attribute
    end
  end
end
