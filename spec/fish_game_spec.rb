require_relative "../lib/fish_game"
require_relative "../lib/person"

describe "Game" do
  let(:person1) { Person.new(0, "Stephen") }
  let(:person2) { Person.new(0, "Mary") }
  let(:person3) { Person.new(0, "Joe") }
  before(:each) do
    @game = Game.new(person1, person2, person3)
    @game.start
    @player1 = @game.player1
    @player2 = @game.player2
    @player3 = @game.player3
  end

  it "players get delt 5 cards each" do
    expect(@player1.hand.length).to eq 5
    expect(@player2.hand.length).to eq 5
    expect(@player3.hand.length).to eq 5
    expect(@game.deck.cards_left).to eq 37
  end

  it "player1 can win" do
    until @game.deck.cards_left == 1
      @player1.take_cards([@game.deck.deal])
      @player2.take_cards([@game.deck.deal])
      @player3.take_cards([@game.deck.deal])
    end
    @player1.take_cards([@game.deck.deal])
    [@player2, @player3].each do |other_player|
      ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"].each do |rank|
        @player1.ask_for(rank, other_player)
      end
    end
    expect(@game.winner.name).to eq "Stephen"
  end
end
