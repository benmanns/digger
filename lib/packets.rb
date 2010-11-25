module Digger
  module Packets
    autoload :Packet, 'packets/packet'
    autoload :Login, 'packets/login'
    autoload :Handshake, 'packets/handshake'
    autoload :PlayerPosition, 'packets/player_position'
    autoload :PlayerState, 'packets/player_state'
  end
end
