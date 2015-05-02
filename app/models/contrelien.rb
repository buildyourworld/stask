class Contrelien < ActiveRecord::Base
	belongs_to :contrelien_poly, polymorphic: true
end
