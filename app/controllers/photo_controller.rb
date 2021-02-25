class PhotoController < ApplicationController
  def photo
    @user_photo_list = Userphoto.joins(inner join Usercomment on Userphoto.userid=Usercomment.userid)
  end
end
