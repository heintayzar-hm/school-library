require_relative 'rental'

class Book
  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end
  attr_accessor :title, :author, :rentals

  def add_rental(date, person)
    rental = Rental.new(date, self, person)
    @rentals << rental unless @rentals.include?(rental)
  end
end
