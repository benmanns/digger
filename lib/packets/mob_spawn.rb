module Digger
  module Packets
    class MobSpawn < Packet
      def self.get_length(buffer = '', options = {})
        20
      end
    end
  end
end
