module Digger
  module Packets
    class PlayerInventory < Packet
      def self.get_length(buffer, options = {})
        if buffer.length >= 7
          items_count = buffer.unpack("x#{1 + 4}n").first
          items_length = 0
          0.upto(items_count - 1) do
            return nil unless buffer.length >= 1 + 4 + 2 + items_length + 2
            item_id = buffer.unpack("x#{1 + 4 + 2 + items_length}n").first
            if item_id == 65535
              items_length += 2
            else
              items_length += 5
            end
          end
          1 + 4 + 2 + items_length
        else
          nil
        end
      end
    end
  end
end
