module Digger
  module Packets
    class PlayerPosition < Packet
      def self.get_length(buffer = '', options = {})
        34
      end
    end
  end
end
