module Tailscale
<<Documentation
Show state of tailscaled and its connections

USAGE
  tailscale status [--active] [--web] [--json]

JSON FORMAT

Warning: this format has changed between releases and might change more
in the future.

For a description of the fields, see the "type Status" declaration at:

https://github.com/tailscale/tailscale/blob/main/ipn/ipnstate/ipnstate.go

(and be sure to select branch/tag that corresponds to the version
 of Tailscale you're running)
Documentation
  class Status < Command # https://tailscale.com/kb/1080/cli#status
    # --active, --active=false   => filter output to only peers with active sessions (not applicable to web mode) (default false)
    # --browser, --browser=false => Open a browser in web mode (default true)
    # --json, --json=false       => output in JSON format (WARNING: format subject to change) (default false)
    # --listen value             => listen address for web mode; use port 0 for automatic (default 127.0.0.1:8384)
    # --peers, --peers=false     => show status of peers (default true)
    # --self, --self=false       => show status of local machine (default true)
    # --web, --web=false         => run webserver with HTML showing status (default false)
    BOOLEAN_FLAGS = %i[active browser json peers self web].freeze
    REQUIRED_VALUE_FLAGS = %i[listen].freeze

    # allow_boolean_flags *BOOLEAN_FLAGS
    # allow_required_value_flags *REQUIRED_VALUE_FLAGS

    class << self
      def as_json
        JSON.parse(new(flags: "--json").standard_output)
      end

      def handle_exit_status(error:, cli: nil, **options)
        super unless error.is_a? ::Terrapin::ExitStatusError

        case cli.standard_error
        when /failed to connect to local tailscaled/
          # failed to connect to local tailscaled; it doesn't appear to be running
          Tailscale::Daemon.new if restart_tailscale_daemon?

          if Tailscale::Status.needs_login?
            # TODO:
            binding.pry
          end
        else
          super
        end
      end

      def backend_state_inquiry
        as_json["BackendState"].snake_case.inquiry
      end
      delegate(*%i[needs_login?], to: :backend_state_inquiry)

      private(*%i[backend_state_inquiry])

      # def command_options(flags: [])
      #
      # end
      # def parse_flags(*args, **options)
      #   # --active, --active=false   => filter output to only peers with active sessions (not applicable to web mode) (default false)
      #   # --browser, --browser=false => Open a browser in web mode (default true)
      #   # --json, --json=false       => output in JSON format (WARNING: format subject to change) (default false)
      #   # --listen value             => listen address for web mode; use port 0 for automatic (default 127.0.0.1:8384)
      #   # --peers, --peers=false     => show status of peers (default true)
      #   # --self, --self=false       => show status of local machine (default true)
      #   # --web, --web=false         => run webserver with HTML showing status (default false)
      #
      #   super(boolean_flags:, required_value_flags:).tap do |flags|
      #     binding.pry
      #   end
      # end

      # def run
      #
      # end

      # def status_attribute
      #   as_json[__callee__.classify]
      # end
      # alias backend_state status_attribute
    end

    # def needs_login?
    #   self.class.as_json["BackendState"] == "NeedsLogin"
    # end
  end
end
