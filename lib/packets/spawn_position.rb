module Digger
  module Packets
    class SpawnPosition < Packet
      def self.get_length(buffer = '', options = {})
        13
      end
    end
  end
end
