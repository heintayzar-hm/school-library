require_relative 'classes/student'
require_relative 'classes/teacher'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
    @user_menu = "
Please choose an option by entering a number:
1 - List all books
2 - List all people
3 - Create a person
4 - Create a book
5 - Create a rental
6 - List all rentals for a given person id
7 - Exit"
  end

  def start
    puts @user_menu
    @user_select = gets.chomp.to_i
    return puts 'Thank you for using this app' if @user_select == 7
    options_for_user(@user_select)
  end

  def options_for_user(user_select)
    case user_select
    when 1
      list_of_all_books
    when 2
      list_of_all_people
    when 3
      create_a_person
    when 4
      create_a_book
    when 5
      create_a_rental
    when 6
      list_of_all_rentals_for_a_given_person_id
    else
      puts 'Please enter a valid number'
    end

    start
  end

  def list_of_all_books
    if @books.empty?
      puts "\033[36mThere are no book in the library yet!!\033[0m"
    else
      @books.each do |book|
        puts "Title: \033[34m#{book.title}\033[0m, Author: \033[34m#{book.author}\033[0m"
      end
    end
  end

  def list_of_all_people
    if @people.empty?
      puts "\033[36mThere are no one in the library yet!!\033[0m"
    else
      @people.each do |person|
        output = "[\033[36m#{person.class}\033[0m] Name: \033[34m#{person.name}\033[0m, " \
                 "ID: \033[34m#{person.id}\033[0m, Age: \033[34m#{person.age}\033[0m"
        puts output
      end
    end
  end

  def create_a_person
    print "\033[36mDo you want to create a student (1) or a teacher (2)? [Input the number]: \033[0m"
    person_class = gets.chomp.to_i
    case person_class
    when 1
      create_a_student
    when 2
      create_a_teacher
    end
  end

  def create_a_student
    print "\033[36mAge: \033[0m"
    age = gets.chomp.to_i
    return puts "\033[31mAge must be a number or a vaild one\033[0m" unless (age.is_a? Integer) && age > 1 && age < 100

    print "\033[36mName: \033[0m"
    name = gets.chomp
    return puts "\033[31mName must have length of 4 to 50\033[0m" unless name.length > 3 && name.length < 50

    print "\033[36mHas parent permission? [Y/N] \033[0m"
    parent_permission = gets.chomp
    parent_permission = parent_permission.downcase == 'y'
    @people << Student.new(age, name, parent_permission: parent_permission)
    puts "\033[36mStudent created successfully\033[0m"
  end

  def create_a_teacher
    print "\033[36mAge: \033[0m"
    age = gets.chomp.to_i
    return puts "\033[31mAge must be a number or a vaild one\033[0m" unless (age.is_a? Integer) && age > 1 && age < 100

    print "\033[36mName: \033[0m"
    name = gets.chomp
    return puts "\033[31mName must have length of 4 to 50\033[0m" unless name.length > 3 && name.length < 50

    print "\033[36mSpecialization: \033[0m"
    specialization = gets.chomp
    specialization = specialization.downcase
    @people << Teacher.new(name, age, specialization)
    puts "\033[36mTeacher created successfully \033[0m"
  end

  def create_a_book
    print "\033[36mTitle: \033[0m"
    title = gets.chomp
    return puts "\033[31mTitle must have length of 3 to 50\033[0m" unless title.length > 2 && title.length < 50

    print "\033[36mAuthor: \033[0m"
    author = gets.chomp
    return puts "\033[31mAuthor must have length of 4 to 50\033[0m" unless author.length > 3 && author.length < 50

    @books << Book.new(title, author)
    puts "\033[36mBook created successfully\033[0m"
  end

  def create_a_rental
    return puts "\033[31mThere is no book or people register yet!!\033[0m" if @books.empty? || @people.empty?

    puts "\033[36mSelect a book from the following list by number\033[0m\n"
    @books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end
    rental_book = @books[gets.chomp.to_i]

    puts "\033[36mSelect a person from the following list by number(not by id)\033[0m\n"
    @people.each_with_index do |person, index|
      puts "#{index}) Name: \033[34m#{person.name}\033[0m, Age: \033[34m#{person.age}\033[0m " \
           "ID: \033[34m#{person.id}\033[0m"
    end
    rental_person = @people[gets.chomp.to_i]

    print "\033[36mDate: \033[0m"

    rental_date = gets.chomp
    @rentals << Rental.new(rental_date, rental_book, rental_person)
    puts "\033[36mRental created successfully\033[0m"
  end

  def list_of_all_rentals_for_a_given_person_id
    return puts "\033[31mThere is no people who register yet!!\033[0m" if @people.empty?

    print "\033[36mID of person: \033[0m"
    id = gets.chomp.to_i
    rentals_of_person_given_by_id = @rentals.filter { |rental| rental.person.id == id }
    return puts "\033[31mThere is no rental for this person!!\033[0m" if rentals_of_person_given_by_id.empty?

    rentals_of_person_given_by_id.each do |rental|
      puts "Date: \033[36m#{rental.date}\033[0m, Book: \033[36m\"#{rental.book.title}\"\033[0m " \
           "by \033[36m#{rental.book.author}\033[0m"
    end
  end

  def error_message(error_message = nil)
    condition = yield
    return unless condition

    if error_message.nil?
      puts "\033[31mThere was an error!!\033[0m"
    else
      puts "\033[31m#{error_message}\033[0m"
    end
    true
  end
end
