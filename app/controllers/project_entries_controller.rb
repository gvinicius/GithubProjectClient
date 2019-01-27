class ProjectEntriesController < ApplicationController
  require 'net/http'
  skip_before_action :verify_authenticity_token
  protect_from_forgery except: :search
  before_action :set_project_entry, only: [:show, :edit, :update, :destroy]

  # GET /project_entries
  # GET /project_entries.json
  def index
    @project_entries = ProjectEntry.all.group_by(&:name)
  end

  # GET /project_entries/1
  # GET /project_entries/1.json
  def show
  end

  # GET /project_entries/1
  # GET /project_entries/1.json
  def search(language=params[:term])
    respond_to do |format|
      @language = language
      results = {}
      source = "https://api.github.com/search/repositories?q=language:#{@language}&sort=stars&order=desc&page=1&per_page=5"
      response = Net::HTTP.get_response(URI.parse(source))
      new_language = ProjectEntry.where(name: @language.downcase.capitalize).empty?
      if response.code == '200' && new_language
        @project_entries = {@language => JSON.parse(response.body)['items'].map do |element|
              result = ProjectEntry.where(name: element['name'])&.first
              info_field = {info: element.except('name', 'language', 'url', 'score').to_json}
              result = ProjectEntry.create(element.slice('name', 'language', 'url', 'score').merge(info_field)) if result.nil?
              result.save
              result
        end}
        format.js{'index'}
      elsif response.code == '200' && !new_language
        @error = true
        format.js { render :js => "alertOld('#{@language}');" }
      else
        @error = true
        format.js { render :js => "errorHandling('#{@language}');" }
      end
    end
  end

  # GET /project_entries/1
  # GET /project_entries/1.json
  def default_search
      languages = %i[ruby python javascript clojure go]
      results = {}
      languages.each{ |language| search(language) }
  end

  def clear_all
    respond_to do |format|
      ProjectEntry.destroy_all
      format.js
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
