module Digger
  module Packets
    class EntityVelocity < Packet
      def self.get_length(buffer = '', options = {})
        11
      end
    end
  end
end
