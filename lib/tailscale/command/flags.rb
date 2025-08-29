require_relative "./flag"

module Tailscale
  class Command
    module Flags
      def inherited(subclass)
        subclass.cattr_accessor :allowed_flags, default: AllowedFlags.new
      end

      def allow_boolean_flags(*flag_names)
        flag_names.each do |boolean_flag_name|
          allowed_flags.allow(boolean_flag_name, Flag::Types::Boolean)
        end
      end

      def allow_required_value_flags(*flag_names)
        flag_names.each do |required_value_flag|
          allowed_flags.allow(required_value_flag, Flag::Types::RequiredValue)
        end
      end

      # def selected_flags_string
      #   selected_flags.map(&:to_s).join(" ")
      # end

      # def flag_names
      #   binding.pry
      # end
      #
      private

      delegate(*%i[select_flags selected_flags], to: :allowed_flags)

      # def boolean_flag_names
      #   const_defined?(:BOOLEAN_FLAGS) ? const_get(:BOOLEAN_FLAGS) : []
      # end

      # allow_flags(
      #   boolean: boolean_flags,
      #   required_value: required_value_flags
      # )
    end
  end
end
