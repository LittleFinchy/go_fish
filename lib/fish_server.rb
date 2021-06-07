require "socket"
require_relative "fish_game"
require_relative "person"

class FishServer
  attr_accessor :games, :lobby

  def initialize
    @games = {}
    @lobby = []
  end

  def port_number
    3335
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def welcome_players_get_name(client)
    if lobby.length < 3
      client.puts "Wait for other players"
    else
      client.puts "Ready to start"
    end
    client.puts "Enter your name: "
    client.read_nonblock(1000).chomp
  end

  def client_to_person(client, name)
    Person.new(client, name)
  end

  def accept_new_client
    client = @server.accept_nonblock # returns a TCPSocket
    name = welcome_players_get_name(client)
    person = client_to_person(client, name)
    lobby.push(person) #push the person
  rescue IO::WaitReadable, Errno::EINTR
    puts "No client to accept"
    # sleep(2)
  end

  def create_game_if_possible
    if lobby.length > 3 # check this later
      game = Game.new(lobby[0], lobby[1], lobby[2])
      games[game] = lobby.shift(3)
      message_players_by_game(game, "Game is starting now")
      game
    end
  end

  def read_message(game, person_index)
    sleep(0.1)
    games[game][person_index].client.read_nonblock(1000).chomp
  rescue IO::WaitReadable
    ""
  end

  def message_players_by_game(game, message)
    # if game
    games[game].each { |person| person.client.puts message }
    # else
    #   lobby.each { |client| client.puts message }
    # end
  end

  def play_round(game, person)
    game.play_round(person)
    # output = game.play_round
    # message_players_by_game(game, output)
  end

  # def play_full_game(game)
  #   game.start
  #   until game.winner
  #     game.people.each do |person|
  #       play_round(game)
  #     end
  #   end
  #   puts "Winner: #{game.winner.name}"
  # end

  def stop
    @server.close if @server
  end
end
