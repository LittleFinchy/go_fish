class Turn
  attr_accessor :person, :all_people, :deck

  def initialize(person, all_people, deck)
    @person = person
    @all_people = all_people
    @deck = deck
  end

  def play
    player_requested = what_player
    card_requested = what_card
    cards_given = person.player.ask_for(card_requested, player_requested)
    draw_if_needed(cards_given.length)
    build_message(player_requested, card_requested, cards_given)
  end

  def what_player
    person.client.puts "Pick a player to ask (enter the number)"
    [all_people - [person]].flatten.each_with_index do |option, i|
      # all_people.each_with_index do |option, i|
      person.client.puts "#{i + 1}: #{option.name}"
    end
    player_pick = read_message(client).to_i - 1
  rescue IO::WaitReadable
    ""
  end

  def what_card
    person.client.puts "Pick a card to ask for (enter the number)"
    person.player.hand.each_with_index do |card, i|
      person.client.puts "#{i}: #{card.rank} of #{card.suit}"
    end
    card_pick = read_message(client).to_i - 1
  rescue IO::WaitReadable
    ""
  end

  def draw_if_needed(num_of_cards_given)
    if num_of_cards_given == 0
      person.player.take_cards([deck.deal])
    end
  end

  def build_message(player_requested, card_requested, cards_given)
    message = "#{person.name} asked #{player_requested.name} for a #{card_requested}"
    message += "\nNumber of cards given: #{cards_given}"
    show_message(message)
  end

  def show_message(message)
    all_people.each { |person| person.client.puts message }
  end

  def read_message(client, message = "")
    while message == ""
      sleep(0.1)
      message = client.read_nonblock(1000).chomp
    end
    message
  rescue IO::WaitReadable
    ""
  end
end
