class MessagesController < ApplicationController
before_action :authenticate_user!

  def create
    # メッセージを作成し、room_idを保持したままチャット画面にリダイレクト
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id))
      if @message.save
        redirect_to room_path(@message.room_id)
      else
        # バリデーションエラー（140文字超え等）の場合
        redirect_back(fallback_location: root_path)
      end
    else
      redirect_back(fallback_location: root_path)
    end
    end
end
