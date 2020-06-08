class archatype < ActiveRecord::Base
    has_many :characters
    has_many :powers
end