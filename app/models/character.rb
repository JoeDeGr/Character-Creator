class Character < ActiveRecord::Base
    belongs_to :user
    has_many :character_locations
    has_many :locations, through: :character_locations
    has_many :character_types
    has_many :archatypes, through: :character_types
    has_many :powers, through: :archatypes
end