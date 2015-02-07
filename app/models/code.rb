class Code < ActiveRecord::Base
  belongs_to :code_actions
  belongs_to :code_types
  has_many :messages
  has_many :reports
end