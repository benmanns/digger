
module Digger
  class ClientConnection < EventMachine::Connection
    def initialize(options = {})
      @options = options
      @options[:host] ||= 'localhost'
      @options[:port] ||= 25565
    end

    def receive_packet(packet)
      data = packet
      packet_class = Digger::Packets::Packet.get_class(data, :mode => :client)
      case
      when packet_class == Digger::Packets::ChatMessage
        id, message_length, data = data.unpack('Cna*')
        message = data.unpack("a#{message_length}").first
        puts "got message #{message}"
        case
        when message == 'respawn'
          puts 'respawning.'
          packet = [0x09].pack('C')
          return nil
        when message == 'random'
          @position = @position == :random ? nil : :random
          puts "random mode: #{@position == :random ? 'on' : 'off'}"
          return nil
        when message == 'fly'
          @position = @position == :fly ? nil : :fly
          puts "fly mode: #{@position == :fly ? 'on' : 'off'}"
          return nil
        when message == 'heal'
          @server_connection.send_data([0x10, 0, 322].pack('CNn'))
          @server_connection.send_data([0x0f, 322, -1, -1, -1, -1].pack('CnNcNc'))
          puts 'healed'
          return nil
        when message == 'autoheal'
          if @autoheal
            @autoheal.cancel
          else
            @autoheal = EventMachine::PeriodicTimer.new(1) do
              @server_connection.send_data([0x10, 0, 322].pack('CNn'))
              @server_connection.send_data([0x0f, 322, -1, -1, -1, -1].pack('CnNcNc'))
              @server_connection.send_data([0x10, 0, @item].pack('CNn')) if @item
            end
          end
          puts "autoheal is #{@autoheal ? 'on' : 'off'}"
          return nil
        when message == 'hole'
          @server_connection.send_data([0x10, 0, 278].pack('CNn'))
          y = @y.floor
          while y > 0
            100.times { @server_connection.send_data([0x0e, 1, @x.floor, y, @z.floor, 1].pack('CCNCNC')) }
            @server_connection.send_data([0x0e, 3, @x.floor, y, @z.floor, 1].pack('CCNCNC'))
            y -= 1
            @server_connection.send_data([0x0b, @x, y + 3, 1 + y + 3, @z, 1].pack('CGGGGC'))
          end
          @server_connection.send_data([0x10, 0, @item].pack('CNn')) if @item
          return nil
        when message == 'bighole'
          @server_connection.send_data([0x10, 0, 278].pack('CNn'))
          y = @y.floor
          while y > 0
            -1.upto(1) do |x_offset|
              -1.upto(1) do |z_offset|
                100.times { @server_connection.send_data([0x0e, 1, @x.floor + x_offset, y, @z.floor + z_offset, 1].pack('CCNCNC')) }
                @server_connection.send_data([0x0e, 3, @x.floor + x_offset, y, @z.floor + z_offset, 1].pack('CCNCNC'))
              end
            end
            y -= 1
            @server_connection.send_data([0x0b, @x, y + 3, 1 + y + 3, @z, 1].pack('CGGGGC'))
          end
          @server_connection.send_data([0x10, 0, @item].pack('CNn')) if @item
          return nil
        when message == 'tnt'
          puts 'tnt tower'
          @server_connection.send_data([0x10, 0, 46].pack('CNn'))
          y = @y.floor - 1
          while y < 128
            @server_connection.send_data([0x0f, 46, @x.floor, y, @z.floor, 0].pack('CnNcNc'))
            y += 1
            @server_connection.send_data([0x0b, @x.floor, y + 3, 1 + y + 3, @z.floor, 1].pack('CGGGGC'))
          end
          @server_connection.send_data([0x10, 0, @item].pack('CNn')) if @item
          return nil
        when message == 'bigtnt'
          puts 'tnt tower'
          @server_connection.send_data([0x10, 0, 46].pack('CNn'))
          y = @y.floor - 1
          while y < 128
            -1.upto(1) do |x_offset|
              -1.upto(1) do |z_offset|
                @server_connection.send_data([0x0f, 46, @x.floor + x_offset, y, @z.floor + z_offset, 0].pack('CnNcNc'))
              end
            end
            y += 1
            @server_connection.send_data([0x0b, @x.floor, y + 3, 1 + y + 3, @z.floor, 1].pack('CGGGGC'))
          end
          @server_connection.send_data([0x10, 0, @item].pack('CNn')) if @item
          return nil
        when message == 'gianttnt'
          puts 'tnt tower'
          @server_connection.send_data([0x10, 0, 46].pack('CNn'))
          y = @y.floor - 1
          while y < 128
            -8.upto(8) do |x_offset|
              -8.upto(8) do |z_offset|
                @server_connection.send_data([0x0f, 46, @x.floor + x_offset, y, @z.floor + z_offset, 0].pack('CnNcNc'))
              end
            end
            y += 1
            @server_connection.send_data([0x0b, @x.floor, y + 3, 1 + y + 3, @z.floor, 1].pack('CGGGGC'))
          end
          @server_connection.send_data([0x10, 0, @item].pack('CNn')) if @item
          return nil
        end
      when packet_class == Digger::Packets::PlayerPosition
        id, @x, @y, @stance, @z, @grounded = data.unpack('CGGGGC')
        @grounded = 1
        packet = if @position
          case @position
          when :random
            random = Random.new
            height = random.rand(5..10)
            [0x0b, @x + random.rand(-5..5), @y + height, 1 + @y + height, @z + random.rand(-5..5), @grounded]
          when :fly
            [0x0b, @x, @y + 5, 1 + @y + 5, @z, @grounded]
          end
        else
          [id, @x, @y, @stance, @z, @grounded]
        end.pack('CGGGGC')
      when packet_class == Digger::Packets::PlayerState
        id, @x, @y, @stance, @z, @yaw, @pitch, @grounded = data.unpack('CGGGGggC')
        @grounded = 1
        packet = if @position
          case @position
          when :random
            random = Random.new
            height = random.rand(5..10)
            [0x0d, @x + random.rand(-5..5), @y + height, 1 + @y + height, @z + random.rand(-5..5), @yaw, @pitch, @grounded]
          when :fly
            [0x0d, @x, @y + 5, 1 + @y + 5, @z, @yaw, @pitch, @grounded]
          end
        else
          [id, @x, @y, @stance, @z, @yaw, @pitch, @grounded]
        end.pack('CGGGGggC')
      when packet_class == Digger::Packets::PlayerGrounded
        @grounded = 1
        if @position
          packet = case @position
          when :random
            random = Random.new
            height = random.rand(5..10)
            [0x0b, @x + random.rand(-5..5), @y + height, 1 + @y + height, @z + random.rand(-5..5), @grounded]
          when :fly
            [0x0b, @x, @y + 5, 1 + @y + 5, @z, @grounded]
          end.pack('CGGGGC')
        else
          [0x0a, 1].pack('CC')
        end
      when packet_class == Digger::Packets::HoldingChange
        id, @item = data.unpack('Cx4n')
        puts "holding #{@item}"
      when packet_class == Digger::Packets::UseEntity
        id, user, target, aggressive = data.unpack('CNNC')
        @server_connection.send_data([0x10, 0, 276].pack('CNn'))
        @server_connection.send_data(packet)
        @server_connection.send_data([0x10, 0, @item].pack('CNn')) if @item
        return nil
      when packet_class == Digger::Packets::PlayerDigging
        id, status, x, y, z, face = data.unpack('CCNCNC')
        @dug ||= {}
        unless [2, 3].include? status or (@dug.has_key?([x, y, z]) and Time.now - @dug[[x, y, z]] < 5)
          @server_connection.send_data([0x10, 0, 278].pack('CNn'))
          300.times { @server_connection.send_data([0x0e, 1, x, y, z, face].pack('CCNCNC')) }
          @server_connection.send_data([0x0e, 3, x, y, z, face].pack('CCNCNC'))
          @server_connection.send_data([0x10, 0, @item].pack('CNn')) if @item
          @dug[[x, y, z]] = Time.now
          return nil
        end
      end
      puts packet_class.to_s unless [Digger::Packets::PlayerGrounded, Digger::Packets::PlayerLook, Digger::Packets::PlayerState, Digger::Packets::PlayerPosition, Digger::Packets::PlayerDigging].include?(packet_class)
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
