require_relative "room"
require_relative "patient"

room = Room.new(capacity: 2)
george = Patient.new(name: "Georges")
pierre = Patient.new(name: "Pierre")
paul = Patient.new(name: "Paul")

room.add_patient(george)
room.add_patient(paul)

puts "jusqu'ici tout va bien"

begin
  room.add_patient(pierre)
  rescue Room::OverCapacityError => e
    puts e.message
    puts "Problème de place"
end

puts "et là ?"

puts "george room : #{george.room}"
p "pierre room : #{pierre.room}"