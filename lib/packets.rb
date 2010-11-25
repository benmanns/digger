module Digger
  module Packets
    autoload :Packet, 'packets/packet'
    autoload :KeepAlive, 'packets/keep_alive'
    autoload :Login, 'packets/login'
    autoload :Handshake, 'packets/handshake'
    autoload :ChatMessage, 'packets/chat_message'
    autoload :PlayerInventory, 'packets/player_inventory'
    autoload :PlayerGrounded, 'packets/player_grounded'
    autoload :PlayerPosition, 'packets/player_position'
    autoload :PlayerLook, 'packets/player_look'
    autoload :PlayerState, 'packets/player_state'
    autoload :PlayerDigging, 'packets/player_digging'
    autoload :PlayerBlockPlacement, 'packets/player_block_placement'
    autoload :HoldingChange, 'packets/holding_change'
    autoload :ArmAnimation, 'packets/arm_animation'
  end
end
