# frozen_string_literal: true

class ProjectEntriesController < ApplicationController
  require 'net/http'
  protect_from_forgery except: %i[search default_search clear_all]
  before_action :set_project_entry, only: :show

  # GET /project_entries
  # GET /project_entries.json
  def index
    @project_entries = ProjectEntry.all.order(:language)
  end

  # GET /project_entries/1
  # GET /project_entries/1.json
  def show; end

  # GET /project_entries/1
  # GET /project_entries/1.json
  def search
    respond_to do |format|
      @project_entries = prepare_entries(params[:term])
      if @project_entries.present?
        format.js
      else
        @error = true
        format.js { render js: 'errorHandling();' }
      end
    end
  end

  # GET /project_entries/1
  # GET /project_entries/1.json
  def default_search
    languages = %w[ruby python javascript clojure go]
    results = []
    @project_entries = languages.map { |language| results << prepare_entries(language) }.flatten.compact
    redirect_to project_entries_index_path
  end

  def clear_all
    respond_to do |format|
      ProjectEntry.destroy_all
      format.js
    end
  end

  private

  def prepare_entries(language)
    results = {}
    source = "https://api.github.com/search/repositories?q=language:#{language}&sort=stars&order=desc&page=1&per_page=5"
    response = Net::HTTP.get_response(URI.parse(source))
    new_language = ProjectEntry.where(name: language.downcase.capitalize).empty?
    if response.code == '200' && new_language
      JSON.parse(response.body)['items'].map { |element| ProjectEntry.upsert_from_github(element) }

    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_project_entry
    @project_entry = ProjectEntry.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_entry_params
    params.permit(:term)
  end
end
