require_relative "../lib/deck"
require_relative "../lib/card"

describe "Deck" do
  let(:deck) { Deck.new() }

  it "should have 52 cards when created" do
    expect(deck.cards_left).to eq 52
  end

  it "should shuffle the deck" do
    expect(deck.shuffle)
    card = deck.deal
    card2 = deck.deal
    card3 = deck.deal
    card4 = deck.deal
    expect([card.rank, card2.rank, card3.rank, card4.rank].uniq.length > 1).to eq true
    expect(deck.cards_left).to eq 48
  end

  it "should deal 5 cards" do
    card = deck.deal
    card2 = deck.deal
    card3 = deck.deal
    card4 = deck.deal
    card5 = deck.deal
    expect([card.rank, card2.rank, card3.rank, card4.rank, card5.rank].uniq.length > 1).to eq true
    expect(deck.cards_left).to eq 47
  end
end
