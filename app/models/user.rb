class User < ActiveRecord::Base
  belongs_to :user_type
  belongs_to :location_type
  has_many :messages
  has_many :reports
end