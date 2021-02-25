class AddForeignKeyToUserComment < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :usercomments, :userphotos
  end
end
