class LocationType < ActiveRecord::Base
  has_many :users
  has_many :reports
end