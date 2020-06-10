class Location < ActiveRecord::Base
    has_many :buildings
    has_many :character_locations
    has_many :characters, through: :character_locations
end