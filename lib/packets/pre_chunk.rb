module Digger
  module Packets
    class PreChunk < Packet
      def self.get_length(buffer = '', options = {})
        10
      end
    end
  end
end
