class Archatype < ActiveRecord::Base
    has_many :characters
    has_many :powers
end