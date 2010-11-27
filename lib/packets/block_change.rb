module Digger
  module Packets
    class BlockChange < Packet
      def self.get_length(buffer = '', options = {})
        12
      end
    end
  end
end
