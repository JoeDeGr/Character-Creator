class Location < ActiveRecord::Base
    has_many :buildings
    has_many :characters, through: :character_locations
end