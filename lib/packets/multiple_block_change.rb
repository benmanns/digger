module Digger
  module Packets
    class MultipleBlockChange < Packet
      def self.get_length(buffer, options = {})
        if buffer.length >= 1 + 4 + 4 + 2
          block_count = buffer.unpack("x#{1 + 4 + 4}n").first
          1 + 4 + 4 + 2 + block_count * 4
        else
          nil
        end
      end
    end
  end
end
