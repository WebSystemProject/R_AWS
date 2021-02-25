class PhotoController < ApplicationController
  def photo
    @user_photo_list = Userphoto.where(userid: params[:id])
  end
end
