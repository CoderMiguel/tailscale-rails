module Tailscale
  class Command
    class AllowedFlags
      attr_reader(*%i[flag_names])

      def initialize
        @flag_names = Set.new
        @command_flags = {}
      end

      def allow(flag_name, flag_class)
        if @flag_names.add?(flag_name)
          command_flags[flag_name] = flag_class.new(name: flag_name)
          # else
          # TODO: either send a message or raise an error
        end
      end

      def select_flags(flags:, **_options)
        command_flags.values_at(*Array.wrap(flags)).map(&:select)
      end

      def selected_flags
        command_flags.values.select(&:selected?)
      end

      private

      attr_reader :command_flags
    end
  end
end
