class Message < ActiveRecord::Base
  belongs_to :users
  belongs_to :codes
  belongs_to :reports
  has_many :reports
end