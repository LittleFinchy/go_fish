require_relative "../lib/player"

describe "Player" do
  let(:player1) { Player.new("Bill", [Card.new("2", "D"), Card.new("7", "D"), Card.new("7", "S"), Card.new("3", "D")]) }
  let(:player2) { Player.new("Bob", [Card.new("7", "C"), Card.new("5", "H"), Card.new("6", "H")]) }
  let(:player3) { Player.new("Mary", [Card.new("7", "H"), Card.new("5", "D")]) }

  it "asking a player for a card will return nothing if that player does not have the requested card" do
    player1.ask_for("2", player2)
    expect(player1.hand.last.rank).to eq "3"
  end

  it "asking player3 for a card will remove the card from player3 hand and put it in player2 hand" do
    player2.ask_for("5", player3)
    expect(player2.hand.last.rank).to eq "5"
  end

  it "asking for a card will find all cards of that rank in the players hand" do
    player3.ask_for("7", player1)
    expect(player3.hand[-1].rank).to eq "7"
    expect(player3.hand[-2].rank).to eq "7"
  end

  it "makes a book if a player has all 4 cards of one rank" do
    player3.ask_for("7", player1)
    player3.ask_for("7", player2)
    expect(player3.books).to eq 1
  end
end
