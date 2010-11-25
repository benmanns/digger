require 'eventmachine'

module Digger
  class ServerConnection < EventMachine::Connection
    def initialize(client_connection)
      @client_connection = client_connection
    end

    def receive_data(data)
      @client_connection.send_data(data)
    end

    def unbind
      unless @client_connection.error?
        @client_connection.close_connection_after_writing
      end
    end
  end
end
