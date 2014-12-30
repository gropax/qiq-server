class NotesController < ApplicationController
  respond_to :json

  def index
    @notes = Note.all
  end

  def show
    @note = Note.find(params[:id])
  end
end
