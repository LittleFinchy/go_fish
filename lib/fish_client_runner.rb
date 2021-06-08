require_relative "fish_client"

puts "Enter the address"
address = gets.chomp
puts "Enter the port number"
port = gets.chomp

client = FishClient.new(address, port)
while true
  output = ""
  until output != ""
    output = client.capture_output
  end
  print output
  client.provide_input(gets.chomp)
end
