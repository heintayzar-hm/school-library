#!/usr/bin/env ruby
require_relative 'app'
def main
  puts 'Welcome to OOP school library app!'
  app = App.new
  app.start
end

main
