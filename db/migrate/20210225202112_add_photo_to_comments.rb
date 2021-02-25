class AddPhotoToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :usercomments, :userphoto
  end
end
