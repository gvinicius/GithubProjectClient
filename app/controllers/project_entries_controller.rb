class ProjectEntriesController < ApplicationController
  before_action :set_project_entry, only: [:show, :edit, :update, :destroy]

  # GET /project_entries
  # GET /project_entries.json
  def index
    @project_entries = ProjectEntry.all
  end

  # GET /project_entries/1
  # GET /project_entries/1.json
  def show
  end

  # GET /project_entries/1
  # GET /project_entries/1.json
  def search
    respond_to do |format|
      format.json { render json: '1', status: '200' }
    end
  end

  # GET /project_entries/new
  def new
    @project_entry = ProjectEntry.new
  end

  # GET /project_entries/1/edit
  def edit
  end

  # POST /project_entries
  # POST /project_entries.json
  def create
    @project_entry = ProjectEntry.new(project_entry_params)

    respond_to do |format|
      if @project_entry.save
        format.html { redirect_to @project_entry, notice: 'Project entry was successfully created.' }
        format.json { render :show, status: :created, location: @project_entry }
      else
        format.html { render :new }
        format.json { render json: @project_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_entries/1
  # PATCH/PUT /project_entries/1.json
  def update
    respond_to do |format|
      if @project_entry.update(project_entry_params)
        format.html { redirect_to @project_entry, notice: 'Project entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_entry }
      else
        format.html { render :edit }
        format.json { render json: @project_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_entries/1
  # DELETE /project_entries/1.json
  def destroy
    @project_entry.destroy
    respond_to do |format|
      format.html { redirect_to project_entries_url, notice: 'Project entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_entry
      @project_entry = ProjectEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_entry_params
      params.permit(:term)
    end
end
