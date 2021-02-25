class Userphoto < ApplicationRecord
  self.table_name = 'userphoto'
  has_many :usercomments
end
