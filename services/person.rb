require_relative "../interface/name_decorator/name_decorator.rb"
require_relative "../interface/name_decorator/captialize_decorator.rb"
require_relative "../interface/name_decorator/trimmer_decorator.rb"
# Create class Person with intaliase id, name, age
class Person < Nameable
  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  # getters for id,name,age
  attr_accessor :name, :age
  attr_reader :id

  # setters for name,age

  # private method is_of_age?
  def of_age?
    @age >= 18
  end

  # Public method can_use_services
  def can_use_services?
    @parent_permission || is_of_age?
  end
  private :of_age?

  def correct_name
    @name
  end
end

person = Person.new(22, 'maximilianus')
person.correct_name
capitalizedPerson = CaptailizeDecorator.new(person)
capitalizedPerson.correct_name
capitalizedTrimmedPerson = TrimmerDecorator.new(capitalizedPerson)
capitalizedTrimmedPerson.correct_name

p capitalizedTrimmedPerson.correct_name == 'Maximilian'