class Usercomment < ApplicationRecord
  self.table_name = 'usercomment'
  belongs_to :userphoto
  belongs_to :userlist
end
