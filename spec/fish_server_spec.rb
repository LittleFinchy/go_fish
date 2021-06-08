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
  let(:clients) { [] }
  let(:server) { FishServer.new }

  before(:each) do
    server.start
  end

  after(:each) do
    server.stop
    clients.each do |client|
      client.close
    end
  end

  it "is not listening on a port before it is started" do
    server.stop
    expect { MockClient.new(server.port_number) }.to raise_error(Errno::ECONNREFUSED)
  end
end

def make_clients_join(number_of_clients, server)
  number_of_clients.times do
    client1 = MockClient.new(server.port_number)
    clients.push(client1)
    server.accept_new_client
    # client1.capture_output
    client1.provide_input("Player 1")
  end
end

describe FishServer do
  let(:clients) { [] }
  let!(:server) { FishServer.new }

  before(:each) do
    server.start
  end

  after(:each) do
    server.stop
    clients.each do |client|
      client.close
    end
  end

  it "accepts new clients" do
    make_clients_join(2, server)
    expect(server.lobby.length).to eq 2
  end

  it "clients get welcome message" do
    client1 = MockClient.new(server.port_number)
    clients.push(client1)
    server.accept_new_client
    client1.provide_input("Player 1")
    expect(client1.capture_output).to eq "Wait for other players... Enter your name: "
  end

  it "third client to join gets welcome message" do
    make_clients_join(2, server)
    client1 = MockClient.new(server.port_number)
    clients.push(client1)
    server.accept_new_client
    client1.provide_input("Player 1")
    expect(client1.capture_output).to eq "Ready to start... Enter your name: "
  end

  it "starts a game if possible" do
    make_clients_join(3, server)
    server.create_game_if_possible
    expect(server.games.count).to eq 1
  end

  it "starts multiple games if possible" do
    make_clients_join(3, server)
    server.create_game_if_possible
    expect(server.games.count).to eq 1
    make_clients_join(3, server)
    server.create_game_if_possible
    expect(server.games.count).to eq 2
  end
end
