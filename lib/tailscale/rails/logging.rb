module Tailscale
  module Rails
    module Logging
      def log_error(error:)
        $stderr.puts "#{tailscale_log_prefix} #{parse_error_message(error:)}"
      end

      private

      def parse_error_message(error:)
        case error
        when Terrapin::CommandLineError
          error.message.split("STDERR:\n\n").last
        else
          error.message
        end.squish
      end

      def tailscale_log_prefix
        "[Tailscale::Rails]:"
      end
    end
  end
end
