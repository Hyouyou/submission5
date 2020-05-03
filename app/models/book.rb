class Book < ApplicationRecord

  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  #いいねしているかどうか
  def favorited_by?(user)
  	favorites.where(user_id: user.id).exists?
  end
  #
  validates :body, length: {maximum: 200}
  validates :title, presence: true
  validates :body, presence: true

end
