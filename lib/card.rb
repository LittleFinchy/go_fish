class Card
  attr_reader :rank, :suit #, :value

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    # @value = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"].index(@rank)
  end

  def show
    puts "#{rank} of #{suit}"
  end

  def ==(other_card)
    @rank == other_card.rank && @suit == other_card.suit
  end
end
