require "socket"
require_relative "../lib/fish_server"

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

describe FishServer do
  before(:each) do
    @clients = []
    @server = FishServer.new
    @server.start
    client1 = MockClient.new(@server.port_number)
    @clients.push(client1)
    @server.accept_new_client
    client1.capture_output
    client1.provide_input("Player 1")
  end

  after(:each) do
    @server.stop
    @clients.each do |client|
      client.close
    end
  end

  it "is not listening on a port before it is started" do
    @server.stop
    expect { MockClient.new(@server.port_number) }.to raise_error(Errno::ECONNREFUSED)
  end

  it "accepts new clients and starts a game if possible" do
    @server.create_game_if_possible
    expect(@server.games.count).to be 0
    client2 = MockClient.new(@server.port_number)
    @clients.push(client2)
    @server.accept_new_client
    client2.provide_input("Player 2")
    client3 = MockClient.new(@server.port_number)
    @clients.push(client3)
    @server.accept_new_client
    client3.provide_input("Player 3")
    @server.create_game_if_possible
    puts @server.lobby.length
    expect(@server.games.count).to eq 1
  end
end
