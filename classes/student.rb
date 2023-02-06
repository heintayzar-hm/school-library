require_relative 'person'
require_relative 'classroom'
# inherits from Person
class Student < Person
  attr_reader :classroom

  def initialize(age, name = 'Unknown', classroom = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  # play_hooky
  def play_hooky
    '¯(ツ)/¯'
  end

  def belongs_to
    @classroom.label
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.add_student(self) unless classroom.students.include?(self)
  end
end
