class ListuserController < ApplicationController
  def userlist
    @user_list = Userlist.all
  end
end
