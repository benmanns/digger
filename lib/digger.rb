require 'eventmachine'

$: << File.join(File.expand_path(File.dirname(__FILE__)))
require 'client_connection'

options = { :client => {}, :server => {} }
options[:client][:host] = ARGV.shift || 'localhost'
options[:client][:port] = ARGV.shift || 25565
options[:server][:host] = ARGV.shift || 'localhost'
options[:server][:port] = ARGV.shift || 25564

EventMachine::run {
  EventMachine::start_server options[:server][:host], options[:server][:port], Digger::ClientConnection, options[:client]
}
