class Admin::MovieCommentsController < ApplicationController

  def destroy
    MovieComment.find(params[:id]).destroy
    redirect_to admin_movie_path(params[:movie_id])
  end


  # private

  # def movie_comment_params
  #   params.require(:movie_comment).permit(:comment)
  # end

end
