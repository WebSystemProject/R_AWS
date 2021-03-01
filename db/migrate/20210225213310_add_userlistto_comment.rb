class AddUserlisttoComment < ActiveRecord::Migration[6.1]
  def change
    add_reference :usercomments, :userlist
  end
end
