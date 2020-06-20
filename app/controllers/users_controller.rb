# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @new_relationship = Relationship.new(follower_id: current_user.id)
    @relationship = Relationship.find_by(follower_id: current_user.id, followed_id: @user.id)
  end
end
