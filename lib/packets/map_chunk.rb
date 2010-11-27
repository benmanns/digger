module Digger
  module Packets
    class MapChunk < Packet
      def self.get_length(buffer, options = {})
        if buffer.length >= 1 + 4 + 2 + 4 + 1 + 1 + 1 + 4
          data_length = buffer.unpack("x#{1 + 4 + 2 + 4 + 1 + 1 + 1}N").first
          1 + 4 + 2 + 4 + 1 + 1 + 1 + 4 + data_length
        else
          nil
        end
      end
    end
  end
end
