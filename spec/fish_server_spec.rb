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
  let!(:server) { FishServer.new }

  before(:each) do
    server.start
    # client1 = MockClient.new(@server.port_number)
    # @clients.push(client1)
    # client1.provide_input("Player 1")
    # @server.accept_new_client
    # client1.capture_output
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

  context "#client_to_person" do
    it "creates a person from a client with a name" do
      client = MockClient.new(server.port_number)
      clients.push(client)
      person = server.client_to_person(client, "Player 2")
      expect(person.name).to eq "Player 2"
    end
  end
end

describe FishServer do
  let(:clients) { [] }
  let!(:server) { FishServer.new }

  before(:each) do
    server.start
    client1 = MockClient.new(server.port_number)
    clients.push(client1)
    client1.provide_input("Player 1")
    server.accept_new_client
  end

  after(:each) do
    server.stop
    clients.each do |client|
      client.close
    end
  end

  it "accepts new clients" do
    client2 = MockClient.new(server.port_number)
    clients.push(client2)
    client2.provide_input("Player 2")
    server.accept_new_client
    expect(server.lobby.length).to eq 2
  end
end
