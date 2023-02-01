require_relative '../interface/name_decorator/name_decorator'
require_relative '../interface/name_decorator/captialize_decorator'
require_relative '../interface/name_decorator/trimmer_decorator'
require_relative 'rental'
require_relative 'book'
# Create class Person with intaliase id, name, age
class Person < Nameable
  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @rentals = []
    @parent_permission = parent_permission
  end

  # getters for id,name,age
  attr_accessor :name, :age, :rentals
  attr_reader :id

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

  # add_rental
  def add_rental(rental)
    @rentals << rental unless @rentals.include?(rental)
  end
end

person = Person.new(18, 'John', parent_permission: true)
book = Book.new('The Hobbit', 'J.R.R. Tolkien')
Rental.new('2021-01-01', book, person)
Rental.new('2021-01-02', book, person)
person_rentals = person.rentals.map(&:date)
book_rentals = book.rentals.map(&:date)
p [person_rentals, book_rentals]
