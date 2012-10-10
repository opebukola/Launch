class UsersController < ApplicationController
	def index
		@users = User.all
	end
	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		respond_to do |format|
			if @user.save
				format.html { redirect_to :back, notice: 'Thanks!'}
				format.js 
			else
				format.html { render 'new'}
				format.js 
			end
		end
	end
end
