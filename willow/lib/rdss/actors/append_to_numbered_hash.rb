module Rdss
  module Actors
    class AppendToNumberedHash < SetHashValues

      def to_numbered_hash(arr)
        num_hash = {}
        arr.each_with_index {|v, i| num_hash[i.to_s] = v}
        num_hash
      end
      
      public
      def call(hash)
        hash.each { |key, value|
          current_values = attributes[key].values
          current_values << value
          attributes[key]=to_numbered_hash(current_values) 
        }
      end

    end
  end
end
