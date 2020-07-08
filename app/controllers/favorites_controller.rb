class FavoritesController < ApplicationController

  before_action :authenticate_user!

  def create
    @favorite = Favorite.new(book_id: params[:book_id], user_id: current_user.id)
    @favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @favorite = Favorite.find_by(book_id: params[:book_id], user_id: current_user.id)
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def favorites_params
    params.require(:favorite).permit(:book_id, :user_id)
  end

end
