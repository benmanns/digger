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
            when 0x03
              Digger::Packets::ChatMessage
            when 0x05
              Digger::Packets::PlayerInventory
            when 0x07
              Digger::Packets::UseEntity
            when 0x08
              Digger::Packets::PlayerHealth
            when 0x09
              Digger::Packets::Respawn
            when 0x0a
              Digger::Packets::PlayerGrounded
            when 0x0b
              Digger::Packets::PlayerPosition
            when 0x0c
              Digger::Packets::PlayerLook
            when 0x0d
              Digger::Packets::PlayerState
            when 0x0e
              Digger::Packets::PlayerDigging
            when 0x0f
              Digger::Packets::PlayerBlockPlacement
            when 0x10
              Digger::Packets::HoldingChange
            when 0x12
              Digger::Packets::ArmAnimation
            when 0x15
              Digger::Packets::PickupSpawn
            when 0xff
              Digger::Packets::Disconnect
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
