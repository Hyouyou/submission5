class RelationshipsController < ApplicationController

	def create
		#linkの時に使う方、メンターさんに教えてもらったやつ
		@user = User.find(params[:id])
		#formの時にネットから引っ張ってきたやつ
		#@user = User.find(params[:relationship][:follow_id])
		following = current_user.follow(@user)
		if following.save
			flash[:success] = 'ユーザーをフォローしました'
			redirect_back(fallback_location: root_path)
		else
			flash.now[:alert] = 'ユーザーのフォローに失敗しました'
			redirect_back(fallback_location: root_path)
		end
	end

	def destroy
		#linkの時の、メンターさんに教えてもっらたやつ
		follow_id = current_user.relationships.find_by(params[:id]).follow_id
		@user = User.find(follow_id)
		following = current_user.unfollow(@user)
		if following.destroy
			flash[:success] = 'ユーザーのフォローを解除しました'
			redirect_back(fallback_location: root_path)
		else
			flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
			redirect_back(fallback_location: root_path)
		end
	end

end


