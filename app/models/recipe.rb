class Recipe < ActiveRecord::Base
	belongs_to :category
	has_many :informations
	has_many :directions
	belongs_to :user

	accepts_nested_attributes_for :informations,
									reject_if: proc { |attributes| attributes['url'].blank? },
									allow_destroy: true
	accepts_nested_attributes_for :directions,
									reject_if: proc { |attributes| attributes['step'].blank? }, 
									allow_destroy: true

	validates :title, :description, presence: true
end
