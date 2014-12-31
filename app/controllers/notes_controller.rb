class NotesController < ApplicationController
  respond_to :json

  before_action :set_note, except: [:index, :create]
  before_action :set_tag, only: [:add_tag, :remove_tag]

  def index
    @notes = Note.all
  end

  def show
  end

  def create
    @note = Note.new(note_params)

    if @note.save
      render :show, status: :created, location: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  def update
    if @note.update(note_params)
      render :show, status: :ok, location: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy
    head :no_content
  end

  def add_tag
    @note.tags << @tag
    render :show, status: :ok, location: @note
  end

  def remove_tag
    @note.tags.delete(@tag)
    head :no_content
  end

  private

    def set_note
      @note = Note.find(params[:id])
    end

    def set_tag
      @tag = Tag.find(params[:tag_id])
    end

    def note_params
      params.require(:note).permit(:content)
    end
end
