class Patient
  attr_accessor :id, :room
  
  def initialize(attributes = {})
    @name = attributes[:name]
    @cured = attributes[:cured] || false
  end
  def cure!
    @cured = true
  end
end