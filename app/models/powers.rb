class Powers < ActiveRecord::Base
    has_many :types, through :type_powers
end