class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:destroy]
  def create
    @photo = Photo.find(params[:photo_id])
    @comment = current_user.comments.new(comment_params)
    @comment.photo_id = @photo.id
    @comment.score = Language.get_data(comment_params[:photo_comment])
    @comment.save
  end

  def destroy
    comment = Comment.find_by(id: params[:id], photo_id: params[:photo_id])
    if user_signed_in?
      @photo = Photo.find(params[:photo_id])
      comment = Comment.find_by(id: params[:id], photo_id: params[:photo_id])
      if comment.user != current_user
        redirect_to current_user
      else
        comment.destroy
      end
    elsif admin_signed_in?
      comment.destroy
      redirect_to request.referer
    else
      redirect_to root_path
    end
  end


   private

  def comment_params
    params.require(:comment).permit(:photo_comment)
  end
end
