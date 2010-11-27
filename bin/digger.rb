#!/usr/bin/env ruby

require 'bundler/setup'
Bundler.require

$: << File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib')
require 'digger'

options = { :client => {}, :server => {} }
options[:client][:host] = ARGV.shift || 'localhost'
options[:client][:port] = ARGV.shift || 25565
options[:server][:host] = ARGV.shift || 'localhost'
options[:server][:port] = ARGV.shift || 25564

EventMachine::run {
  EventMachine::start_server options[:server][:host], options[:server][:port], Digger::ClientConnection, options[:client]
}
