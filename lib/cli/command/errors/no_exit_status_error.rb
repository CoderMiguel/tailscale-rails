module CLI
  module Command
    class NoExitStatusError < Error
      private

      def default_message
        "No Exit Status is present on the cli instance, try running the command first."
      end
    end
  end
end
