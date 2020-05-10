class SearchsController < ApplicationController

	def search
		#Viewのformで取得したパラメータをモデルに渡す
		if params[:option] == "user"
			@users = User.search(params[:term], params[:choice])
			#render 'users/index',indexに検索結果のuserだけ表示される。
		elsif params[:option] == "book"
			@books = Book.search(params[:term], params[:choice])
			@books = @books.page(params[:page])
		end
	end
end
