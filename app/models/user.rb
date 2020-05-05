class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image
  validates :introduction, length: {maximum: 50}
  validates :name, length: {in: 2..20}
  validates :name, presence: true

  #フォロー機能
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  #through:sourceとセットのこと多い。多対多で中間テーブルが複数ある場合、throughオプションで中間テーブルを指定すれば、経路を決めることができる。
  #source:class_nameとほぼ同じらしい。throughを使うような中間テーブルがある場合はsource。一対多のような中間テーブルを使わない場合はclass_nameらしい。
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  #class_name:一つのモデルに対して二つのアソシエーション経路を組む場合に多用
  #foreign_key:難しい
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end
