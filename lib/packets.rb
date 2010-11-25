module Digger
  module Packets
    autoload :Packet, 'packets/packet'
    autoload :KeepAlive, 'packets/keep_alive'
    autoload :Login, 'packets/login'
    autoload :Handshake, 'packets/handshake'
    autoload :PlayerGrounded, 'packets/player_grounded'
    autoload :PlayerPosition, 'packets/player_position'
    autoload :PlayerState, 'packets/player_state'
  end
end
