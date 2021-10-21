require 'csv'
require_relative 'patient'

class PatientRepository
  def initialize(attributes = {})
  # On réhydrate la liste des chambres
    @room_repository = attributes[:room_repository]
    @csv_file = attributes[:csv_file]
    @patients = load_csv
  end

  def all
    @patients
  end

  def write_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << ["id", "name", "cured", "room_id"]
      @patients.each do |patient|
        csv << [patient.id, patient.name, patient.cured, patient.room.id]
      end
    end
  end

  def load_csv
    # on recharge la liste des patients pour la réhydrater, ce qui dans ce code suppose qu'on ait réhydraté les chambres d'abord
    patients = []
    options = {headers: :first_row, header_converters: :symbol}
    CSV.foreach(@csv_file, options) do |row|
      patient = Patient.new(
        id: row[:id], name: row[:name], cured: row[:cured]
      )
      patients << patient
      room_id = row[:room_id]
      room = @room_repository.find(room_id.to_i)
      room.add_patient(patient)
    end
    patients
  end
end