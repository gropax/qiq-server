class NotesController < ApplicationController
  respond_to :json

  def index
    @notes = Note.all
    respond_with @notes
  end
end
