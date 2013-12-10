class Event < ActiveRecord::Base
	belongs_to :users, :dependent => :destroy
	has_one :place, :dependent => :destroy
	accepts_nested_attributes_for :place 
	mount_uploader :picture, PictureUploader
end
