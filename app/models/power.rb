class Power < ActiveRecord::Base
    include Helpers::InstanceMethods
    has_many :type_powers
    has_many :archatypes, through: :type_powers
    has_many :characters, through: :archatypes
end