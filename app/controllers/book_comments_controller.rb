class BookCommentsController < ApplicationController
  
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @comment = @book.book_comments.new(book_comments_params)
    @comment.user_id = current_user.id
    @comment.save
    @comments = @book.book_comments
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment = BookComment.find(params[:id])
    @comment.destroy
    @comments = @comment.book
    @book = Book.find(params[:book_id])
    # redirect_back(fallback_location: root_path)
  end

  private

  def book_comments_params
    params.require(:book_comment).permit(:comment, :book_id, :user_id)
  end

end
