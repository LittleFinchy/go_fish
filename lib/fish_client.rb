require "socket"

class FishClient
  attr_reader :socket, :output

  def initialize(address = "localhost", port)
    @socket = TCPSocket.new(address, port)
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
