require_relative 'rental'

class Book
  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end
  attr_accessor :title, :author, :rentals

  def add_rental(rental)
    @rentals << rental unless @rentals.include?(rental)
  end
end
