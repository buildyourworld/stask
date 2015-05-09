class Contrelien < ActiveRecord::Base
	belongs_to :contrelien_poly, polymorphic: true
	belongs_to :user
end
