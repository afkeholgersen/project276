class Preference < ApplicationRecord
	belongs_to :user
	has_and_belongs_to_many :dietlabel
	has_and_belongs_to_many :healthlabel
end
