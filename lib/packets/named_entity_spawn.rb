module Digger
  module Packets
    class NamedEntitySpawn < Packet
      def self.get_length(buffer, options = {})
        if buffer.length >= 1 + 4 + 2
          username_length = buffer.unpack("x#{1 + 4}n").first
          1 + 4 + 2 + username_length + 4 + 4 + 4 + 1 + 1 + 2
        else
          nil
        end
      end
    end
  end
end
