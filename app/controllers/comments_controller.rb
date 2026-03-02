class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]
    
  # POST /articles/:article_id/comments
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:article_id/comments/:id
    def destroy
    @comment = Comment.find(params[:id])

    # Vérification : Seul l'auteur du commentaire peut le supprimer
    if @comment.user == current_user
        @comment.destroy
        render json: { message: "Commentaire supprimé avec succès" }, status: :ok
    else
        render json: { error: "Tu ne peux pas supprimer le commentaire d'un autre !" }, status: :forbidden
    end
end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
