
module Digger
  class ClientConnection < EventMachine::Connection
    def initialize(options = {})
      @options = options
      @options[:host] ||= 'localhost'
      @options[:port] ||= 25565
    end

    def receive_packet(packet)
      packet
    end

    def post_init
      @buffer = ''
      EventMachine.connect(@options[:host], @options[:port], ServerConnection, self) do |server_connection|
        @server_connection = server_connection
        receive_data
      end
    end

    def receive_data(data = '')
      @buffer << data
      unless @server_connection.nil? or @buffer.length == 0
        packet_class = Digger::Packets::Packet.get_class(@buffer, :mode => :client)
        unless packet_class == Digger::Packets::Packet
          length = packet_class.get_length(@buffer, :mode => :client)
          if length and @buffer.length >= length
            data = @buffer.slice!(0, length)
            data = receive_packet(data)
            @server_connection.send_data(data) if data
          end
        else
          raise "Unknown packet id 0x#{@buffer.unpack('C').first.to_s(16)}: #{@buffer.dump}"
        end
      end
    end

    def unbind
      unless @server_connection.nil? or @server_connection.error?
        @server_connection.close_connection_after_writing
      end
    end
  end
end
