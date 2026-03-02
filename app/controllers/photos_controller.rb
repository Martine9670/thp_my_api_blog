class PhotosController < ApplicationController
  # On force l'auth pour créer, modifier ou supprimer
  before_action :authenticate_user!, except: [:index, :show]
  # On cherche la photo uniquement pour les actions qui en ont besoin
  before_action :set_photo, only: [:show, :update, :destroy]

  # GET /photos
  def index
    @photos = Photo.all
    # On inclut l'utilisateur pour voir qui a posté la photo
    render json: @photos, include: [:user]
  end

  # GET /photos/1
  def show
    render json: @photo, include: [:user]
  end

  # POST /photos
  def create
    # On crée la photo DIRECTEMENT liée au current_user (celui du Token)
    @photo = current_user.photos.build(photo_params)

    if @photo.save
      render json: @photo, status: :created
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /photos/1
  def update
    # Vérification : est-ce que cette photo appartient bien à l'utilisateur connecté ?
    if @photo.user == current_user
      if @photo.update(photo_params)
        render json: @photo
      else
        render json: @photo.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Tu n'es pas le propriétaire de cette photo" }, status: :forbidden
    end
  end

  # DELETE /photos/1
  def destroy
    if @photo.user == current_user
      @photo.destroy!
      render json: { message: "Photo supprimée avec succès" }
    else
      render json: { error: "Action non autorisée" }, status: :forbidden
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    # On ne permet de passer que l'URL. Le user_id est géré par current_user pour éviter les tricheries.
    params.require(:photo).permit(:url)
  end
end