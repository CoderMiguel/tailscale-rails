module Tailscale
  class Up < Command
    # class << self
    #   def handle_exit_status(error:, cli: nil, **options)
    #     super do |error_message|
    #       case error_message
    #       when /'tailscale up' requires mentioning all non-default flags/
    #         # Error: changing settings via 'tailscale up' requires mentioning all non-default flags.
    #         # To proceed, either re-run your command with --reset or use the command below to explicitly mention the
    #         # current value of all non-default settings:
    #         #   tailscale up --auth-key='tskey-auth-kK9p9Lbabf11CNTRL-qSG3nkKqBGG9i41HKJW8FGN69LpqH2Wwe
    #         #                --hostname=development-app'
    #         #                --hostname=development-app
    #         # cli.reset
    #         binding.pry
    #       else
    #         super
    #       end
    #     end
    #   end
    # end

    def initialize(*args, **options)
      @flags = options.fetch(:flags, %W[--auth-key=#{ENV["TAILSCALE_AUTH_KEY"]} --hostname=#{::Rails.env}-app])
      # tailscale up --auth-key=${TAILSCALE_AUTH_KEY} --hostname=my-app
      super(flags:)
    end

    # def reset
    #   new(flags: @flags + " --reset")
    # end
  end
end
