require_relative "../lib/fish_server"
require_relative "../lib/fish_game"
require_relative "../lib/person"
require_relative "../lib/turn"
require_relative "../lib/fish_client"

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
  number_of_clients.times do |x|
    client1 = FishClient.new(server.port_number)
    clients.push(client1)
    client1.provide_input(["Mary", "Joe", "Stephen"][x])
    server.accept_new_client
    # client1.capture_output
  end
end

describe "Turn" do
  let(:clients) { [] }
  let(:server) { FishServer.new }

  before(:each) do
    server.start
    make_clients_join(3, server)
    @game = server.create_game_if_possible
    @turn = Turn.new(@game.all_people[0], @game.all_people, @game.deck)
  end

  after(:each) do
    server.stop
    clients.each do |client|
      client.close
    end
  end

  context "#what_player" do
    it "asks what player to fish from" do
      clients[0].provide_input("1")
      player = @turn.what_player
      expect(player).to eq @game.all_people[1].player
    end

    it "asks what player to fish from" do
      clients[0].provide_input("2")
      player = @turn.what_player
      expect(player).to eq @game.all_people[2].player
    end

    # xit "asks what player to fish from" do
    #   @game.start
    #   clients[0].provide_input("9")
    #   player = @turn.what_player
    #   clients[0].provide_input("2")
    #   expect(player).to eq @game.all_people[2].player
    # end
  end

  context "#what_card" do
    it "askes what player to fish from" do
      @game.start
      clients[0].provide_input("2")
      card = @turn.what_card
      expect(card).to eq @turn.person.player.hand[1]
    end
  end

  # xcontext "#draw_if_needed" do
  #   it "askes what player to fish from" do
  #     @all_people[0].provide_input("1")
  #     player = @turn.what_player
  #     expect(player.hand.last.rank).to eq "3"
  #   end
  # end

  # xcontext "#build_message" do
  #   it "askes what player to fish from" do
  #     player = @turn.what_player
  #     puts "found player"
  #     puts player
  #     expect(player.hand.last.rank).to eq "3"
  #   end
  # end

  # xcontext "#show_message" do
  #   it "askes what player to fish from" do
  #     @all_people[0].provide_input("1")
  #     player = @turn.what_player
  #     puts "found player"
  #   end
  # end

  # xcontext "#play" do
  #   it "askes what player to fish from" do
  #     @all_people[0].provide_input("1")
  #     player = @turn.what_player
  #     puts player
  #     expect(player.hand.last.rank).to eq "3"
  #   end
  # end
end
