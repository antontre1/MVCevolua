load "room.rb"
load "patient.rb"
load "room_repository.rb"
rr = RoomRepository.new(csv_file: "rooms.csv")
r3 = Room.new(capacity: 4)
puts "all"
p rr.all
puts "add"
rr.add(r3)
puts "find nb1"
p rr.find(1)