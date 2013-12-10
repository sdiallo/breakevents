class Place < ActiveRecord::Base
  belongs_to :event
  geocoded_by :street
  after_validation :geocode, :if => :street_changed?
end
