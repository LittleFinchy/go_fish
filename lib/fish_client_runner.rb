require_relative "fish_client"

# puts "Enter the address"
# address = gets.chomp
# puts "Enter the port number"
# port = gets.chomp

address = "localhost"
port = 3335

client = FishClient.new(address, port)
while true
  output = ""
  until output != ""
    output = client.capture_output
  end
  print output
  if output.include?(":")
    client.provide_input(gets.chomp)
  end
end
