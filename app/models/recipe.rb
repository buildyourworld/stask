class Recipe < ActiveRecord::Base
	belongs_to :category
	has_many :informations, dependent: :destroy
	has_many :directions, dependent: :destroy
	belongs_to :user

	accepts_nested_attributes_for :informations,
									reject_if: proc { |attributes| attributes['url'].blank? },
									allow_destroy: true
	accepts_nested_attributes_for :directions,
									reject_if: proc { |attributes| attributes['step'].blank? }, 
									allow_destroy: true

	validates :title, presence: true

	before_destroy :clear_features

	private
	def clear_features
		informations.clear
		directions.clear
	end
end
