require_relative 'person'
# inherits from person
class Teacher < Person
  attr_accessor :specialization

  # initialize
  def initialize(name, age, specialization)
    super(name, age)
    @specialization = specialization
  end

  # can_use_services
  def can_use_services?
    true
  end
  private :can_use_services?
end
