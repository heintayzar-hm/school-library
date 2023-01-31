require_relative 'name_decorator'

class BaseDecorator < Nameable
  def initialize(nameable)
    super()
    @nameable = nameable
  end
  attr_accessor :nameable
  def correct_name
    @nameable.correct_name
  end
end
