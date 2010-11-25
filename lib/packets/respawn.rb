module Digger
  module Packets
    class Respawn < Packet
      def self.get_length(buffer = '', options = {})
        1
      end
    end
  end
end
