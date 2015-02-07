class Code_type < ActiveRecord::Base
  belongs_to :code_actions
  has_many :codes
end