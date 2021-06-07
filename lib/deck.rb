require_relative "card"

class Deck
  attr_reader :cards_left

  def build_deck
    suits = ["H", "D", "C", "S"]
    ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    suits.each do |suit|
      ranks.each do |rank|
        @cards.push(Card.new(rank, suit))
      end
    end
  end

  def initialize
    @cards = []
    build_deck
    shuffle
    @cards_left = @cards.length
  end

  def deal
    @cards_left -= 1
    @cards.pop
  end

  def shuffle
    @cards.shuffle!
  end
end
