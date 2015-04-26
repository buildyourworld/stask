class Direction < ActiveRecord::Base
	acts_as_votable
	belongs_to :recipe
end
