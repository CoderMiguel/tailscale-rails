module Tailscale
  class Up < Command
    def initialize(*args, **options)
      # @flags =
      # tailscale up --auth-key=${TAILSCALE_AUTH_KEY} --hostname=my-app
      super(flags: "--auth-key=#{ENV["TAILSCALE_AUTH_KEY"]} --hostname=#{::Rails.env}-app")
    end
  end
end
