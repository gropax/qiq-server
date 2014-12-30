class NotesController < ApplicationController
  respond_to :json

  def index
    @notes = Note.all
  end
end
