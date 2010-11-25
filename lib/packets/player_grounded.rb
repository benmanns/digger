module Digger
  module Packets
    class PlayerGrounded < Packet
      def self.get_length(buffer = '', options = {})
        2
      end
    end
  end
end
