class User < ApplicationRecord
	belongs_to :preference
	belongs_to :savedrecipe
end
