require_relative "../lib/player"

class Person
  attr_accessor :name, :player, :client

  def initialize(client, name)
    @client = client
    @name = name
    @player = Player.new(name)
  end
end
