module CLI
  class Binary < ::Terrapin::CommandLine
    TERRAPIN_ERRORS = ::Terrapin.constants.map { |c| ::Terrapin.const_get(c) }.select { |c| c.try(:<=, StandardError) }.freeze

    class << self
      def available?
        which.then { |result| result.success? && result.error_output.empty? }
      end

      def binary
        module_parent.name.snake_case.to_sym
      end

      # def cli_instance
      #   ::Terrapin::CommandLine.new(binary, ":subcommand :flags")
      # # rescue StandardError => e
      # #   binding.pry
      # end

      def subcommand
        name.demodulize.snake_case.to_sym
      end

      def unhandled(error:, **_options)
        # TODO: consider wrapping as a Tailscale::Error with better formatting
        puts "Unhandled Error from: #{error.backtrace[1]}"
        raise error
      end
      alias handle_command_not_found unhandled
      alias handle_exit_status       unhandled

      def handle_terrapin(error:, **options)
        case error
        when ::Terrapin::ExitStatusError     # then
          handle_exit_status(error:, **options)
        # when ::Terrapin::CommandNotFoundError then handle_command_not_found(cli:, error:, **options)
        else unhandled(error:)
        end
      end

      private

      def help
        # TODO: Fix help command to show binary help
        #  similar to which:
        # CLI::Which.new(subcommand: options.fetch(:subcommand, binary)).tap(&:run)
      end

      def which(**options)
        CLI::Which.new(subcommand: options.fetch(:subcommand, binary)).tap(&:run)
      end
    end
    delegate(*%i[handle_terrapin unhandled], to: :class)
    delegate(*%i[binary subcommand], to: :class, private: true)

    attr_reader(*%i[flags subcommand])

    def initialize(*args, **options)
      @flags = options.fetch(:flags, nil)
      @subcommand = options.fetch(:subcommand, self.class.subcommand)
      super(binary, ":subcommand :flags", shell: true).tap do
        run(flags:, subcommand:)
      end
    rescue *TERRAPIN_ERRORS => e then handle_terrapin(cli: self, error: e)
    rescue StandardError => e    then unhandled(error: e)
    end

    def rerun_command
      tap { run(flags:, subcommand:) }
    end

    def run_as_detached_process
      Process.spawn(command_string).tap { |pid| Process.detach(pid) }
    end

    def standard_error
      output.error_output
    end

    def standard_output
      output.output
    end

    def success?
      raise CLI::Command::NoExitStatusError.new(cli:) if exit_status.nil?

      exit_status.zero?
    end

    # def to_s
    #   binding.pry
    # end
  end
end
