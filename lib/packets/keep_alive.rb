module Digger
  module Packets
    class KeepAlive < Packet
      def self.get_length(buffer = '', options = {})
        1
      end
    end
  end
end
