module CLI
  module Command
    class Error < StandardError
      def initialize(*args, **options)
        super(options.fetch(:message, default_message))
      end

      private

      def default_message
        nil
      end
    end
  end
end
