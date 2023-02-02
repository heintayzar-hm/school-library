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
  def add_rental(date, book)
    rental = Rental.new(date, book, self)
    @rentals << rental unless @rentals.include?(rental)
  end
end

person = Person.new(18, 'John', parent_permission: true)
book = Book.new('The Hobbit', 'J.R.R. Tolkien')
book2 = Book.new('T-------Hobbit', 'J.R.R. Tolkien')
person.add_rental('2020-10-10', book)
person.add_rental('2020-10-11', book)
book2.add_rental('2020-10-10', person)
person_rentals = person.rentals.map { |rental| rental.book.title }
book_rentals = book.rentals.map { |rental| rental.person.name }
p [person_rentals, book_rentals]
