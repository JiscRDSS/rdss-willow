require 'singleton'
module Enumerations
  module Decoders
    class File
      include Singleton
      class << self
        public
        def call(section)
          instance.call(section)
        end

        def sections
          instance.sections
        end

        private
        def instance
          @__instance__ ||= new
        end
      end

      public
      def call(section)
        @__cache__[section] && @__cache__[section]['enum']
      end

      def sections
        @__cache__.keys
      end

      private
      def initialize(filename="#{Rails.root.to_s}/config/schema/current/enumeration.json")
        @__cache__ = JSON.parse(::File.read(filename))['definitions']
      end
    end
  end
end
