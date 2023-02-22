class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @photo = Photo.find(params[:photo_id])
    @comment = current_user.comments.new(comment_params)
    @comment.photo_id = @photo.id
    @comment.save
  end

  def destroy
    Comment.find_by(id: params[:id], photo_id: params[:photo_id]).destroy
    @photo = Photo.find(params[:photo_id])
  end


   private

  def comment_params
    params.require(:comment).permit(:photo_comment)
  end
end
