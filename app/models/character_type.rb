class CharacterType < ActiveRecord::Base
    belongs_to :character
    belongs_to :archatype
end