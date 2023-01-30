# Create class Person with intaliase id, name, age
class Person
  def initialize(name= "Unknown", age,parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

# getters for id,name,age
  attr_reader :id, :name, :age

# setters for name,age
  attr_writer :name, :age

# private method is_of_age?
  def is_of_age?
    @age >= 18
  end

# Public method can_use_services
    def can_use_services?
        @parent_permission || is_of_age?
    end
  private :is_of_age?
end
