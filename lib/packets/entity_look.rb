module Digger
  module Packets
    class EntityLook < Packet
      def self.get_length(buffer = '', options = {})
        7
      end
    end
  end
end
