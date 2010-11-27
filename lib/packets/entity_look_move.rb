module Digger
  module Packets
    class EntityLookMove < Packet
      def self.get_length(buffer = '', options = {})
        10
      end
    end
  end
end
