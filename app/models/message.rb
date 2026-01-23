class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  # 140字制限のバリデーション
  validates :message, presence: true, length: { maximum: 140 }
end
