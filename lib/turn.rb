class Turn
  def initialize(person, all_people)
    @person = person
    @all_people = all_people
  end

  def play
    player_requested = what_player
    card_requested = what_card
    cards_given = @person.player.ask_for(card_requested, player_requested)
    build_message(player_requested, card_requested, cards_given)
  end

  def what_player
  end

  def what_card
  end

  def build_message(player_requested, card_requested, cards_given)
    message = "#{person.name} asked #{player_requested.name} for a #{card_requested}"
    message += "\nNumber of cards given: #{cards_given}"
    show_message(message)
  end

  def show_message(message)
    @all_people.each { |person| person.client.puts message }
  end
end
