module Digger
  module Packets
    class PlayerDigging < Packet
      def self.get_length(buffer = '', options = {})
        12
      end
    end
  end
end
