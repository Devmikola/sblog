class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { maximum: 240 }
  validates :text, presence: true, length: { maximum: 860 }
end