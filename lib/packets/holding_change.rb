module Digger
  module Packets
    class HoldingChange < Packet
      def self.get_length(buffer = '', options = {})
        7
      end
    end
  end
end
