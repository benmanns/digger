module Digger
  module Packets
    class PickupSpawn < Packet
      def self.get_length(buffer = '', options = {})
        23
      end
    end
  end
end
