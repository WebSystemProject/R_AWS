class AddForeignKeytoUserComments < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :usercomments, :userlists
  end
end
