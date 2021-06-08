require_relative "../lib/fish_server"

server = FishServer.new()
server.start
while true
  server.accept_new_client
  game = server.create_game_if_possible
  if game
    Thread.new(game) { |game| server.play_full_game(game) }
  end
end
