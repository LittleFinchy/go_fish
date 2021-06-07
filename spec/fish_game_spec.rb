require_relative "../lib/fish_game"

describe "Game" do
  before(:each) do
    @game = Game.new(Player.new("Stephen"), Player.new("Mary"), Player.new("Joe"))
    @game.start
  end

  it "players get delt 5 cards each" do
    expect(@game.player1.hand.length).to eq 5
    expect(@game.player2.hand.length).to eq 5
    expect(@game.player3.hand.length).to eq 5
    expect(@game.deck.cards_left).to eq 37
  end

  it "player1 can win" do
    until @game.deck.cards_left == 1
      @game.player1.take_cards([@game.deck.deal])
      @game.player2.take_cards([@game.deck.deal])
      @game.player3.take_cards([@game.deck.deal])
    end
    @game.player1.take_cards([@game.deck.deal])
    [@game.player2, @game.player3].each do |other_player|
      ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"].each do |rank|
        @game.player1.ask_for(rank, other_player)
      end
    end
    expect(@game.winner.name).to eq "Stephen"
  end
end
