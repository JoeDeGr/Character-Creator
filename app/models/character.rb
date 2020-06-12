require_relative './concerns/helpers'

class Character < ActiveRecord::Base
    include Helpers::InstanceMethods
    belongs_to :user
    has_many :character_locations
    has_many :locations, through: :character_locations
    has_many :character_types
    has_many :archatypes, through: :character_types
    has_many :powers, through: :archatypes
    has_many :character_buildings
    has_many :buildings, through: :character_buildings
end