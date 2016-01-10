class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  has_many :child, class_name: 'Comment', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Comment'

  validates :text, presence: true, length: { maximum: 860 }
end