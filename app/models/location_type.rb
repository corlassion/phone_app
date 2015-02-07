class Location_type < ActiveRecord::Base
  has_many :users
  has_many :reports
end