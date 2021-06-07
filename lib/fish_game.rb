require_relative "player"
require_relative "deck"
# require_relative "turn"

class Game
  attr_reader :player1, :player2, :player3, :deck

  def initialize(player1, player2, player3, players = [], num_of_players = 3) #players are instances of object Player
    @player1 = player1
    @player2 = player2
    @player3 = player3
    @players = [@player1, @player2, @player3]
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
    @players.each do |player|
      if player.hand.length != 0
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

  def play_round
    turn = Turn.new(player1)
    turn.play
  end
end
