module Digger
  module Packets
    class EntityMove < Packet
      def self.get_length(buffer = '', options = {})
        8
      end
    end
  end
end
