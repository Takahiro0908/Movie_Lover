class Public::MovieCommentsController < ApplicationController

  def create
    @movie = Movie.find(params[:movie_id])
    @comment = current_user.movie_comments.new(movie_comment_params)
    @comment.movie_id = @movie.id
    if @comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      render :comments #render先にjsファイルを指定
    else
      render :error #render先にjsファイルを指定
    end
  end

  def destroy
    MovieComment.find_by(id: params[:id], movie_id: params[:movie_id]).destroy
    flash.now[:alert] = 'コメントを削除しました'
    #renderしたときに@movieのデータがないので@movieを定義
    @movie = Movie.find(params[:movie_id])
    render :comments #render先にjsファイルを指定
  end


  private

  def movie_comment_params
    params.require(:movie_comment).permit(:comment)
  end

end
