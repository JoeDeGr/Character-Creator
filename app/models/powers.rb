class Powers < ActiveRecord::Base
    has_many :archatypes, through :type_powers
end