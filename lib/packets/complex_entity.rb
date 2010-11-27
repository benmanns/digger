module Digger
  module Packets
    class ComplexEntity < Packet
      def self.get_length(buffer, options = {})
        if buffer.length >= 1 + 4 + 2 + 4 + 2
          data_length = buffer.unpack("x#{1 + 4 + 2 + 4}n").first
          1 + 4 + 2 + 4 + 2 + data_length
        else
          nil
        end
      end
    end
  end
end
