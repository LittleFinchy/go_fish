require_relative "../lib/fish_server"
require_relative "../lib/fish_game"
require_relative "../lib/person"
require_relative "../lib/turn"

class MockClient
  attr_reader :socket
  attr_reader :output, :name

  def initialize(port)
    @socket = TCPSocket.new("localhost", port)
  end

  def provide_input(text)
    @socket.puts(text)
  end

  def capture_output(delay = 0.1)
    sleep(delay)
    @output = @socket.read_nonblock(1000).chomp # not gets which blocks
  rescue IO::WaitReadable
    @output = ""
  end

  def close
    @socket.close if @socket
  end
end

def make_clients_join(number_of_clients, server)
  number_of_clients.times do
    client1 = MockClient.new(server.port_number)
    clients.push(client1)
    client1.provide_input("Player 1")
    server.accept_new_client
    client1.capture_output
  end
end

describe "Turn" do
  let(:clients) { [] }
  let(:server) { FishServer.new }
  # let(:game) { server.games[0] }
  # let(:person) { game.all_people[0] }
  # let(:turn) { Turn.new(person, game.all_people, game.deck) }

  before(:each) do
    server.start
    make_clients_join(3, server)
    @game = server.create_game_if_possible
    @all_people = @game.all_people
    @turn = Turn.new(@all_people[0], @all_people, @game.deck)
  end

  after(:each) do
    server.stop
    clients.each do |client|
      client.close
    end
  end

  context "#what_player" do
    it "askes what player to fish from" do
      @all_people[0].provide_input("1")
      player = @turn.what_player
      puts "found player"
      puts player
      expect(player.hand.last.rank).to eq "3"
    end
  end

  # it "asking a player for a card will return nothing if that player does not have the requested card" do
  #   player1.ask_for("2", player2)
  #   expect(player1.hand.last.rank).to eq "3"
  # end
end

#what_player
#what_card
#draw_if_needed
#build_message
#show_message
#play
