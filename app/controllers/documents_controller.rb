# frozen_string_literal: true

class DocumentsController < ApplicationController
  before_action :set_document, only: %i[show edit update destroy]
  before_action :authenticate_account!

  # GET /documents
  def index
    if current_account.level < 2
      redirect_to new_phone_path
    else
      @documents = current_account.profile.documents
    end
  end

  # GET /documents/new
  def new
    @document = Document.new
    @images = @document.images.build
  end

  # POST /documents
  def create
    @document = Document.new(document_params)
    if @document.update(profile_id: current_account.profile.id)
      params[:images]['upload'].each do |a|
        begin
          @images = @document.images.create!(upload: a, document_id: @document.id)
        rescue ActiveRecord::RecordInvalid
          @document.destroy
          flash[:alert] = 'Some fields are empty or invalid'
          render :new
        end
      end
      redirect_to index_path, notice: 'Document was successfully created.'
    else
      flash[:alert] = 'Some fields are empty or invalid'
      render :new
    end
  end

  # DELETE /documents/1
  def destroy
    @document.destroy

    redirect_to documents_url, notice: 'Document was successfully destroyed.'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def document_params
    params.require(:document).permit(:profile_id, :doc_type, :doc_number, :doc_expire, images_attributes: [:id, :document_id, :upload])
  end
end
