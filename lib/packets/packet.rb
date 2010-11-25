module Digger
  module Packets
    class Packet
      def self.get_length(buffer = '', options = {})
      end

      def self.get_class(buffer = '', options = {})
        Digger::Packets::Packet
      end
    end
  end
end
