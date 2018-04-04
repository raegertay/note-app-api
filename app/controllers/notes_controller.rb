class NotesController < ApplicationController
  before_action :set_note, only: [:show, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.order(:id)
  end

  # GET /notes/1
  # GET /notes/1.json
  def show

  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)

    if @note.save
      render :show, status: :created, location: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    if @note.update(note_params)
      render :show, status: :ok, location: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    @notes = Note.order(:id)
    render json: @notes
  end

  # def sync

  # end

  def sync
    sync_hash.each do |note_attributes|
      note = Note.find_or_create_by(id: note_attributes[:id])
      note.update(title: note_attributes[:title], body: note_attributes[:body])
      # if note[:id]
      #   Note.find(note[:id]).update(title: note[:title], body: note[:body])
      # else
      #   Note.create(title: note[:title], body: note[:body])
      # end
    end

    @notes = Note.order(:id)
    render json: @notes
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Record not found' }, status: 404
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def note_params
    params.require(:note).permit(:title, :body)
  end
  
  def sync_hash
    params[:message]
  end
end
