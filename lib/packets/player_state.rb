module Digger
  module Packets
    class PlayerState < Packet
      def self.get_length(buffer = '', options = {})
        42
      end
    end
  end
end