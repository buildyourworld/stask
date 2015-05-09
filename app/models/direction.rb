class Direction < ActiveRecord::Base
	acts_as_votable
	belongs_to :recipe
	belongs_to :user
	has_many :contrelien, as: :contrelien_poly
end
