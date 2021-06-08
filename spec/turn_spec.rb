require_relative "../lib/fish_game"
require_relative "../lib/person"
require_relative "../lib/turn"

describe "Turn" do
  let(:clients) { [] }
  let(:server) { FishServer.new }
  let(:turn) { Turn.new(person, all_people, deck) }

  before(:each) do
    server.start
  end

  after(:each) do
    server.stop
    clients.each do |client|
      client.close
    end
  end

  # it "" do
  #   turn.what_player()
  #   expect(player1.hand.last.rank).to eq "3"
  # end

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
