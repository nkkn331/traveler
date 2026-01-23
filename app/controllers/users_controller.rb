class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(5).reverse_order
  end

  def show
     @user = User.find(params[:id])
     @posts = @user.posts.page(params[:page]).per(8).reverse_order
     @following_users = @user.following_user
     @follower_users = @user.follower_user
    end
  
  #DM機能用の追記
  # ログインしているユーザーと、表示されているユーザー（相手）のエントリーを取得
     @currentUserEntry = Entry.where(user_id: current_user.id)
     @userEntry = Entry.where(user_id: @user.id)

    # 自分自身のページでない場合のみ実行
    unless @user.id == current_user.id
        @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          # すでに共通のroom_idを持つエントリーが存在するか確認
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end

      # 共通の部屋がまだない場合、新しく作成するためのインスタンスを用意
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
    #ここまでがDM機能用の追記終了
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end
 
   def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end
  
  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image)
  end
end
