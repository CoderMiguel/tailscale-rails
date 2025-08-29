
module Tailscale
  class Command
    module Flag
      FORMATS = %i[long short].freeze

      attr_reader(*%i[flag_name selected type value])

      class << self
        def allow(...)
          raise NotImplementedError
        end
      end

      def initialize(name:, type:, value: @default_value)
        @flag_name = name
        @type = type
        @value = value
      end

      def select
        return true if selected?

        @selected = true
      end

      def selected?
        @selected ||= false
      end

      def to_s(format:, with_value:)
        case format.to_sym
        when :long then to_long_format(with_value:)
        when :short then to_short_format(with_value:)
        else
          binding.pry
        end
        # case format.to_sym
        # when :long
        #   to_command_long_format.then do |long|
        #     with_value ? binding.pry : long
        #   end
        # when :short then to_command_short_format if value
        # else raise UnknownFormatError.new(format:)
        # end
      end

      private

      # def append_value_to(string)
      #   binding.pry
      # end

      def to_long_format(with_value:)
        "--#{flag_name}".tap do |formatted_string|
          append_value_to(formatted_string) if with_value
        end
      end

      def to_short_format(with_value:)
        to_long_format(with_value: false)[1..2].tap do |formatted_string|
          append_value_to(formatted_string) if with_value
        end
      end
    end
  end
end
