module Digger
  module Packets
    class HitEntity < Packet
      def self.get_length(buffer = '', options = {})
        6
      end
    end
  end
end
