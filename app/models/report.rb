class Report < ActiveRecord::Base
  belongs_to :location_types
  belongs_to :users
  belongs_to :codes
  belongs_to :messages
  has_many :messages
end