class RoomsController < ApplicationController

  before_action :authenticate_user!

  def create
    # ルームの作成
    @room = Room.create
    # 自分のEntry（参加記録）作成
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    # 相手のEntry（参加記録）作成（フォームから送られてきたuser_idを使用）
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    # そのルームに自分が参加しているか確認（URL直打ち対策）
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end
end