class CreateUserlists < ActiveRecord::Migration[6.1]
  def change
    create_table :userlists do |t|
      t.integer :userid
      t.string :username
      t.string :userphoto

      t.timestamps
    end
  end
end
