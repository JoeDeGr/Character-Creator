class Building < ActiveRecord::Base
    include Helpers::InstanceMethods
    belongs_to :location
    has_many :character_buildings
    has_many :characters, through: :character_buildings
end