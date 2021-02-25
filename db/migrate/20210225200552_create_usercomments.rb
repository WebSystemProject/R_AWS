class CreateUsercomments < ActiveRecord::Migration[6.1]
  def change
    create_table :usercomments do |t|
      t.integer :commentid
      t.string :comment
      t.time :createddate
      t.integer :userid
      t.integer :userphoto

      t.timestamps
    end
  end
end
