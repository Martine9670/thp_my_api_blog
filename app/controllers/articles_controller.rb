class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: %i[ show update destroy ]

  # GET /articles
  def index
    if current_user
      # Si l'utilisateur est connecté : il voit le public + SES articles privés
      @articles = Article.where(private: false).or(Article.where(user: current_user))
    else
      # Si personne n'est connecté : on ne voit que le public
      @articles = Article.where(private: false)
    end

    render json: @articles
  end

  # GET /articles/1
  def show
    @article = Article.find(params[:id])

    # Si l'article est privé ET que l'utilisateur n'est pas connecté
    if @article.private && current_user.nil?
      render json: { error: "Accès refusé : cet article est privé." }, status: :unauthorized
    else
      render json: @article
    end
  end
  
  # POST /articles
  def create
    # On crée l'article en le liant directement à l'utilisateur connecté
    @article = current_user.articles.build(article_params)

    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    # On cherche l'article UNIQUEMENT parmi ceux de l'utilisateur connecté
    @article = current_user.articles.find(params[:id])

    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy!
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
  def article_params
    # On utilise require et permit, c'est la valeur sûre
    params.require(:article).permit(:title, :content, :private)
  end
end
