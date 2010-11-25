module Digger
  module Packets
    class Handshake < Packet
      def self.get_length(buffer, options = {})
        if buffer.length >= 3
          username_length = buffer.unpack('xn').first
          3 + username_length
        else
          nil
        end
      end
    end
  end
end
