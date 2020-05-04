class Favorite < ApplicationRecord

	belongs_to :user
	belongs_to :book

	#一人が一つの投稿に対して、一つだけいいねを付けられる。book_idとuser_idの組が1組しかないようにバリデーション
	validates_uniqueness_of :book_id, scope: :user_id

end
