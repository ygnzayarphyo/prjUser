class Micropost < ApplicationRecord
  belongs_to :account
  default_scope -> { order(created_at: :desc) }
  
  validates :account_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
