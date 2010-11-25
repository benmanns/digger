module Digger
  module Packets
    class Packet
      def self.get_length(buffer = '', options = {})
      end

      def self.get_class(buffer = '', options = {})
        if buffer.length >= 1
          case buffer.unpack('C').first
            when 0x00
              Digger::Packets::KeepAlive
            when 0x01
              Digger::Packets::Login
            when 0x02
              Digger::Packets::Handshake
            when 0x0a
              Digger::Packets::PlayerGrounded
            when 0x0b
              Digger::Packets::PlayerPosition
            when 0x0c
              Digger::Packets::PlayerLook
            when 0x0d
              Digger::Packets::PlayerState
            when 0x12
              Digger::Packets::ArmAnimation
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
