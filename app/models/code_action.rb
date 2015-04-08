class CodeAction < ActiveRecord::Base
  has_many :codes
  has_many :code_types
end