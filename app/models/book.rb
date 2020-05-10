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

  #検索機能
  def Book.search(term, how_search)
    if how_search == "perfect"
      Book.where(title: term)
    elsif how_search == "front"
      Book.where(['title LIKE ?', "#{term}%"])
    elsif how_search == "back"
      Book.where(['title LIKE ?', "%#{term}"])
    elsif how_search == "part"
      Book.where(['title LIKE ?', "%#{term}%"])
    else
      Book.all
    end
  end
  #
end
