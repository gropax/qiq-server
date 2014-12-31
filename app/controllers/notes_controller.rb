class NotesController < ApplicationController
  respond_to :json

  def index
    @notes = Note.all
  end

  def show
    @note = Note.find(params[:id])
  end

  def create
    @note = Note.new(note_params)

    if @note.save
      render :show, status: :created, location: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  private

    def note_params
      params.require(:note).permit(:content)
    end
end
