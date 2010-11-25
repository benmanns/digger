module Digger
  module Packets
    class Login < Packet
      def self.get_length(buffer, options = {})
        if buffer.length >= 7
          username_length = buffer.unpack('x5n').first
          if buffer.length >= 7 + username_length + 2
            password_length = buffer.unpack("x#{7 + username_length}n").first
            7 + username_length + 2 + password_length + 8 + 1
          else
            nil
          end
        else
          nil
        end
      end
    end
  end
end