module Tailscale
  class Daemon < ::CLI::Binary
    attr_reader(*%i[pid])

    class << self
      def cli_instance
        # TODO: pass args to CLI::Binary to build this instance
        ::Terrapin::CommandLine.new(binary, ":flags > /dev/null 2>&1")
      end

      private

      def binary
        :tailscaled
      end

  #     `tailscaled --help`
  #     Usage of tailscaled:
  #                -bird-socket string
  #     path of the bird unix socket
  #     -cleanup
  #     clean up system state and exit
  #     -config string
  #     path to config file, or 'vm:user-data' to use the VM's user-data (EC2)
  # -debug string
  #       listen address ([ip]:port) of optional debug server
  # -encrypt-state
  #       encrypt the state file on disk; uses TPM on Linux and Windows, on all other platforms this flag is not supported
  # -no-logs-no-support
  #       disable log uploads; this also disables any technical support
  # -outbound-http-proxy-listen string
  #       optional [ip]:port to run an outbound HTTP proxy (e.g. "localhost:8080")
  # -port value
  #       UDP port to listen on for WireGuard and peer-to-peer traffic; 0 means automatically select (default 4000)
  # -socket string
  #       path of the service unix socket (default "/var/run/tailscale/tailscaled.sock")
  # -socks5-server string
  #       optional [ip]:port to run a SOCK5 server (e.g. "localhost:1080")
  # -state string
  #       absolute path of state file; use 'kube:<secret-name>' to use Kubernetes secrets or 'arn:aws:ssm:...' to store in AWS SSM; use 'mem:' to not store state and register as an ephemeral node. If empty and --statedir is provided, the default is <statedir>/tailscaled.state. Default: /var/lib/tailscale/tailscaled.state
  # -statedir string
  #       path to directory for storage of config state, TLS certs, temporary incoming Taildrop files, etc. If empty, it's derived from --state when possible.
  #       -tun string
  #     tunnel interface name; use "userspace-networking" (beta) to not use TUN (default "tailscale0")
  #     -verbose int
  #     log verbosity level; 0 is default, 1 or higher are increasingly verbose
  #     -version
  #     print version information and exit
    end

    def initialize(*args, **options)
      # TODO: make these configurable
      @flags = "--tun=userspace-networking --socks5-server=localhost:1055"

      Process.spawn(command_string).tap do |pid|
        @pid = pid
        Process.detach(pid) if options.fetch(:detached, true)
        Tailscale.up if Tailscale::Status.needs_login?
      end
    end

    def command_string
      self.class.cli_instance.command(flags:).gsub(/'/, "")
    end
  end
end
