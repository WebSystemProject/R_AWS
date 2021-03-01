class Userlist < ApplicationRecord
  self.table_name = 'userlist'
  has_many :usercomments
end