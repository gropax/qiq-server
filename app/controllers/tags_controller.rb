class TagsController < ApplicationController
  respond_to :json

  before_action :set_tag, only: [:show, :update, :destroy]

  def index
    @tags = Tag.all
  end

  def show
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      render :show, status: :created, location: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  def update
    if @tag.update(tag_params)
      render :show, status: :ok, location: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy
    head :no_content
  end

  private

    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:name)
    end
end
