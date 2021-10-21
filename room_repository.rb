require 'csv'
require_relative 'room'
require 'pry'

class RoomRepository
  def initialize(attributes = {} )
    @csv_file = attributes[:csv_file]
    @room_repository = load_csv
    p @next_id = @room_repository.length + 1
  end

  def add(room)
    room.id = @next_id
    @next_id += 1
    @room_repository << room
    write_csv
  end

  def all
    @room_repository
  end

  def find(id)
    @room_repository[id-1]
  end

  def load_csv
    rooms = []
    csv_options = {headers: :first_row, header_converters: :symbol, col_sep: ',', force_quotes: true, quote_char: '"'}
    CSV.foreach(@csv_file, csv_options) do |room|
      new_room = Room.new(capacity: room[:capacity].to_i)
      new_room.id = room[:id].to_i
      p room
      rooms << new_room
    end
    rooms
  end

  def write_csv
   # csv_options = {headers: :first_row, header_converters: :symbol}
    CSV.open(@csv_file, 'w', { col_sep: ',', force_quotes: true, quote_char: '"' }) do |csv|
      csv << ["id", "capacity"]
      @room_repository.each do |room|
        csv << [room.id, room.capacity]
      end
    end
  end
end