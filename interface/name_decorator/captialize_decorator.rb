require_relative 'base_decorator.rb'

class CaptailizeDecorator < BaseDecorator
    def correct_name
        @nameable.correct_name.capitalize
    end
end