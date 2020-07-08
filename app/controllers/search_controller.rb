class SearchController < ApplicationController

  def search
    @range = params[:range]
    match = params[:match]
    search_word = params[:search_word]

    if @range == '2'
      @book = search_book(match, search_word)
    elsif @range == '1'
      @user = search_user(match, search_word)
    elsif @range == '0'
      redirect_back(fallback_location: root_path)
      flash[:notice] = "「User」か「Book」を選んでください"
    end
  end

  private

  def search_user(match, search_word)
    if match == "forward"
      User.where("name like?", "#{search_word}%")
    elsif match == "backward"
      User.where("name like?", "%#{search_word}")
    elsif match == "perfect"
      User.where("name like?", "#{search_word}")
    elsif match == "partial"
      User.where("name like?", "%#{search_word}%")
    end
  end

  def search_book(match, search_word)
    if match == "forward"
      Book.where("title like?", "#{search_word}%")
    elsif match == "backward"
      Book.where("title like?", "%#{search_word}")
    elsif match == "perfect"
      Book.where("title like?", "#{search_word}")
    elsif match == "partial"
      Book.where("title like?", "%#{search_word}%")
    end
  end

end
