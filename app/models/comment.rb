class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  has_many :children, class_name: 'Comment', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Comment'

  validates :text, presence: true, length: { maximum: 860 }
  before_save :set_id_in_post

  def set_id_in_post
    return if self.persisted?
    max_id_in_post = Comment.where(post_id: self[:post_id]).maximum(:id_in_post)
    max_id_in_post ? self[:id_in_post] = max_id_in_post + 1 : self[:id_in_post] = 1
  end
end