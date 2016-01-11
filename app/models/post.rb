class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { maximum: 240 }
  validates :text, presence: true, length: { maximum: 860 }

  def short_text(length = 55)
  	result = self[:text][0, length]
  	self[:text].length > length ? "#{result}..." : result
  end
end