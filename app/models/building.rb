class Building < ActiveRecord::Base
    include Helpers::InstanceMethods
    belongs_to :location
    has_many :character_buildings
    has_one :character, through: :character_buildings
end