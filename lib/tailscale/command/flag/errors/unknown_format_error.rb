module Tailscale
  class Command
    module Flag
      class UnknownFormatError < Error
        def initialize(format:)
          @format = format
        end

        def message
          "Unknown format: #{format}. Use #{flag_format_options}"
        end

        private

        def flag_format_options
          Flag::FORMATS.to_sentence(two_words_connector: " or " , last_word_connector: " or ")
        end
      end
    end
  end
end
