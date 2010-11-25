require 'eventmachine'

module Digger
  class ServerConnection < EventMachine::Connection
    def initialize(client_connection)
      @client_connection = client_connection
    end

    def post_init
      @buffer = ''
    end

    def receive_data(data)
      @buffer << data
      unless @buffer.length == 0
        packet_class = Digger::Packets::Packet.get_class(@buffer, :mode => :server)
        unless packet_class == Digger::Packets::Packet
          length = packet_class.get_length(@buffer, :mode => :server)
          if length and @buffer.length >= length
            @client_connection.send_data(@buffer.slice!(0, length))
          end
        else
          raise "Unknown packet id 0x#{@buffer.unpack('C').first.to_s(16)}: #{@buffer.dump}"
        end
      end
    end

    def unbind
      unless @client_connection.error?
        @client_connection.close_connection_after_writing
      end
    end
  end
end
