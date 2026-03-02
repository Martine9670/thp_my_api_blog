class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy, :update]

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

  # PATCH/PUT /articles/:article_id/comments/:id
    def update
    @comment = Comment.find(params[:id])

    if @comment.user == current_user
        if @comment.update(comment_params)
        render json: @comment, status: :ok
        else
        render json: @comment.errors, status: :unprocessable_entity
        end
    else
        render json: { error: "Tu ne peux pas modifier le commentaire d'un autre !" }, status: :forbidden
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

    # GET /articles/:article_id/comments
# GET /articles/:article_id/comments
    def index
        @article = Article.find(params[:article_id])
        # On demande à Rails d'inclure les infos de l'utilisateur qui a écrit le comm
        render json: @article.comments, include: [:user]
    end
    
  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
