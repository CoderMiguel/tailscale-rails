# frozen_string_literal: true

require "terrapin"
require_relative "./rails/railtie" if defined?(Rails)

# gem_lib_dir = File.join("..", File.dirname(File.dirname(__FILE__)))
# gem_lib_files = ["**", nil].flat_map { |sub_dirs| Dir[File.join(gem_lib_dir, *[sub_dirs, "*.rb"].compact)] }
#
# gem_files_to_require = gem_lib_files.reject do |path|
#   path == __FILE__ || (path =~ /railtie/ unless defined?(Rails::Railtie))
# end
#
# sorted_gem_files_to_require = gem_files_to_require.sort_by do |file_path|
#   case file_path
#   when /\/cli\// then 0
#   when /\/refinements\// then 1
#   when /command.rb/ then 2
#   when /\/rails\// then file_path =~ /logging/ ? 3 : 4
#   else 5
#   end
# end
#
# sorted_gem_files_to_require.each do |file|
#   # puts "requiring: #{file}"
#   require file
# end

# TODO: build a generator to install the Tailscale binary

module Tailscale
  module Rails
    extend ActiveSupport::Concern
    extend ActiveSupport::Autoload

    class_methods do
      def eager_load!
        binding.pry
        # ConfigurationHelpers.eager_load!
        # Configuration.eager_load!
      end
    end

    class << self
      include ClassMethods
    end
  end
end
