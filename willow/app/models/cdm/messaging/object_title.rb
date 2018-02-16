module Cdm
  module Messaging
    class ObjectTitle
      class << self
        def call(object)
          { objectTitle: object.title }
        end
      end
    end
  end
end