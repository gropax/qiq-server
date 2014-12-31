class BuffersController < ApplicationController
  respond_to :json

  before_action :set_buffer, except: [:index, :create]
  before_action :set_note, only: [:add_note, :remove_note]

  def index
    @buffers = Buffer.all
  end

  def show
  end

  def create
    @buffer = Buffer.new(buffer_params)

    if @buffer.save
      render :show, status: :created, location: @buffer
    else
      render json: @buffer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @buffer.update(buffer_params)
      render :show, status: :ok, location: @buffer
    else
      render json: @buffer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @buffer.destroy
    head :no_content
  end

  def add_note
    @buffer.notes << @note
    render :show, status: :ok, location: @buffer
  end

  def remove_note
    @buffer.notes.delete(@note)
    head :no_content
  end

  private

    def set_buffer
      @buffer = Buffer.find(params[:id])
    end

    def set_note
      @note = Note.find(params[:note_id])
    end

    def buffer_params
      params.require(:buffer).permit(:name)
    end
end
