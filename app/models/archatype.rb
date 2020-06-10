class Archatype < ActiveRecord::Base
    has_many :character_types
    has_many :characters, through: :character_types
    has_many :type_powers
    has_many :powers, through: :type_powers
end