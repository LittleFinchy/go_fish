class Player
  attr_reader :name, :hand, :books

  def initialize(name, hand = [])
    @name = name
    @hand = hand
    @books = 0
  end

  def take_cards(cards_won)
    @hand = cards_won.concat(@hand)
    # check_for_books
  end

  def check_for_books
    ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"].each do |rank|
      book_test = @hand.select { |card| card.rank == rank }
      if book_test.length == 4
        @books += 1
        @hand -= book_test
      end
    end
  end

  def ask_for(rank, player)
    @hand.concat(player.lose_cards(rank))
    check_for_books
  end

  def lose_cards(rank)
    outgoing = []
    @hand.each do |my_card|
      if my_card.rank == rank
        outgoing.push(my_card)
      end
    end
    @hand -= outgoing
    outgoing
  end

  def show_hand
    @hand.each { |card| card.show }
  end
end
