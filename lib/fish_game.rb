require_relative "player"
require_relative "deck"
require_relative "turn"

class Game
  attr_reader :player1, :player2, :player3, :deck, :all_people

  def initialize(person1, person2, person3, people = [], num_of_players = 3)
    @player1 = person1.player
    @player2 = person2.player
    @player3 = person3.player
    @all_people = [person1, person2, person3]
  end

  def start
    @deck = Deck.new()
    until deck.cards_left == 37 #deal 5 cards to each player
      player1.take_cards([deck.deal])
      player2.take_cards([deck.deal])
      player3.take_cards([deck.deal])
    end
  end

  def game_ended
    ended = true
    all_people.each do |person|
      if person.player.hand.length != 0
        ended = false
      end
    end
    ended
  end

  def winner
    if game_ended
      if player1.books > player2.books && player1.books > player3.books
        player1
      elsif player2.books > player3.books
        player2
      else
        player3
      end
    end
  end

  def play_round(person)
    turn = Turn.new(person, all_people, deck)
    turn.play
  end
end
