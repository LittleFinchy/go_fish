require_relative "../lib/card"

describe "Card" do
  it "two cards are not eq" do
    card = Card.new("7", "H")
    card2 = Card.new("7", "D")
    card3 = Card.new("5", "C")
    card4 = Card.new("2", "C")
    expect(card == card2).to eq false
    expect(card3 == card4).to eq false
  end

  it "shows the rank of a card" do
    card = Card.new("7", "H")
    expect(card.rank).to eq "7"
    card2 = Card.new("J", "H")
    expect(card2.rank).to eq "J"
  end
end
