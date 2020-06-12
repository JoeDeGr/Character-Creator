require_relative './concerns/helpers'

class Archatype < ActiveRecord::Base
    include Helpers::InstanceMethods
    has_many :character_types
    has_many :characters, through: :character_types
    has_many :type_powers
    has_many :powers, through: :type_powers
end