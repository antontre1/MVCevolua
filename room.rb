class Room

  class OverCapacityError < Exception
  end
  attr_accessor :id
  attr_reader :capacity
  
  def initialize(attributes = {})
    p @capacity = attributes[:capacity].to_i
    @patients = []
  end

  def full?
    @patients.length == @capacity
  end

  def add_patient(patient)
    if full?
      fail OverCapacityError, "Room is full!"
    else
      @patients << patient
      patient.room = self
    end
  end
end