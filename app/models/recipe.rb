class Recipe < ActiveRecord::Base

	has_many :informations
	has_many :directions

	accepts_nested_attributes_for :informations,
									reject_if: proc { |attributes| attributes['url'].blank? },
									allow_destroy: true
	accepts_nested_attributes_for :directions,
									reject_if: proc { |attributes| attributes['step'].blank? }, 
									allow_destroy: true

	validates :title, :description, presence: true
end
