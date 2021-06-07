# require_relative "../lib/fish_game"
# require_relative "../lib/person"

# describe "Game" do
#   let(:person1) { Person.new(0, "Stephen") }
#   let(:person2) { Person.new(0, "Mary") }
#   let(:person3) { Person.new(0, "Joe") }
#   before(:each) do
#     @game = Game.new(person1, person2, person3)
#     @game.start
#   end

# require_relative "../lib/turn"

# describe "Turn" do
#   let(:person1) { Person.new(0, "Stephen") }
#   let(:other_people) { [Person.new(0, "Mary"), Person.new(0, "Joe")] }
#   let(:turn) { Turn.new(person1, other_people) }

#   # it "asking a player for a card will return nothing if that player does not have the requested card" do
#   #   player1.ask_for("2", player2)
#   #   expect(player1.hand.last.rank).to eq "3"
#   # end
# end
