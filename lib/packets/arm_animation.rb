module Digger
  module Packets
    class ArmAnimation < Packet
      def self.get_length(buffer = '', options = {})
        6
      end
    end
  end
end
