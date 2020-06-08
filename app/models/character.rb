class Character < ActiveRecord::Base
    has_many :locations, through: :character_locations
    belongs_to :type
end