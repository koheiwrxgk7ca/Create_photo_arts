class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    photo = Photo.find(params[:photo_id])
    photo_comment = current_user.comments.new(comment_params)
    photo_comment.photo_id = photo.id
    if photo_comment.save
      redirect_to request.referer
    else
      render phot_path(@photo.id)
    end
  end

  def destroy
    Comment.find_by(id: params[:id], photo_id: params[:photo_id]).destroy
    redirect_to request.referer
  end


   private

  def comment_params
    params.require(:comment).permit(:photo_comment)
  end
end
