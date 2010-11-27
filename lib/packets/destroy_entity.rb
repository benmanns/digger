module Digger
  module Packets
    class Entity < Packet
      def self.get_length(buffer = '', options = {})
        5
      end
    end
  end
end
