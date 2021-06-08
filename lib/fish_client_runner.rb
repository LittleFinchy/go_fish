require_relative "fish_client"

# puts "Enter the address"
# address = gets.chomp
# puts "Enter the port number"
# port = gets.chomp
#####
address = "localhost"
port = 3335

client = FishClient.new(address, port)
while true
  output = ""
  until output != ""
    output = client.capture_output
  end
  puts output
  if output.include?(":")
    client.provide_input(gets.chomp)
  end
end
################################

# CONNOR

# require_relative "fish_client"

# print "Enter the network: "
# network = gets.chomp
# print "Enter the port number: "
# port_number = gets.chomp.to_i
# client = FishClient.new(network, port_number)
# while true
#   output = ""
#   until output != ""
#     output = client.capture_output
#   end
#   if output.include?(": ")
#     print output
#     client.provide_input(gets.chomp)
#   else
#     puts output
#   end
# end

#TREVOR
#CLIENT RUNNER SCRIPT

# client = SocketClient.new("10.0.0.185", 3336)
# loop do
#   server_message = ""
#   until server_message != ""
#     server_message = client.capture_output
#   end
#   puts(server_message)
#   if server_message.include?("do you want")
#     client.provide_input(gets.chomp)
#   end
# end
