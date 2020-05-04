class BookComment < ApplicationRecord

	belongs_to :user
	belongs_to :book

	#空のコメントは削除できない事
	validates :comment, presence: true
end
