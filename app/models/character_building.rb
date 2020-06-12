class CharacterBuilding < ActiveRecord::Base
    belongs_to :character
    belongs_to :building
end