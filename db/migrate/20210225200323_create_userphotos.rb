class CreateUserphotos < ActiveRecord::Migration[6.1]
  def change
    create_table :userphotos do |t|
      t.integer :photoid
      t.string :photourl
      t.time :createddate
      t.integer :userid

      t.timestamps
    end
  end
end
