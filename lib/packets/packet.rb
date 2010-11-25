module Digger
  module Packets
    class Packet
      def self.get_length(buffer = '', options = {})
      end

      def self.get_class(buffer = '', options = {})
        if buffer.length >= 1
          case buffer.unpack('C').first
            when 0x01
              Digger::Packets::Login
            when 0x02
              Digger::Packets::Handshake
            else
              Digger::Packets::Packet
          end
        else
          Digger::Packets::Packet
        end
      end
    end
  end
end
