module Digger
  module Packets
    class TimeUpdate < Packet
      def self.get_length(buffer = '', options = {})
        9
      end
    end
  end
end
