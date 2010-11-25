module Digger
  module Packets
    class Disconnect < Packet
      def self.get_length(buffer, options = {})
        if buffer.length >= 3
          message_length = buffer.unpack('xn').first
          3 + message_length
        else
          nil
        end
      end
    end
  end
end
