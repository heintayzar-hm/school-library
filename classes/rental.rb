class Rental
  def initialize(date, book = nil, person = nil)
    @date = date
    self.belongs_to_book = book unless book.nil?
    self.belongs_to_person = person unless person.nil?
  end

  attr_accessor :date, :book, :person

  def belongs_to_book=(book)
    @book = book
    @book.add_rental(self) unless @book.rentals.include?(self)
  end

  def belongs_to_person=(person)
    @person = person
    @person.add_rental(self) unless @person.rentals.include?(self)
  end
end
