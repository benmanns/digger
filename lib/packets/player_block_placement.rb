module Digger
  module Packets
    class PlayerBlockPlacement < Packet
      def self.get_length(buffer = '', options = {})
        13
      end
    end
  end
end
