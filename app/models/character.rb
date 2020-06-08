class Character < ActiveRecord::Base
    belongs_to :user
    has_many :character_locations
    has_many :locations, through: :character_locations
    has many :character_types
    has many :archatypes, through: :character_types
    has many :powers, through: :archatypes
end