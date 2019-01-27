# frozen_string_literal: true

Rails.application.routes.draw do
  get 'project_entries/index'
  get 'project_entries/show'
  root 'project_entries#index'

  resources :project_entries do
    collection do
      get :default_search
      get :search, defaults: { format: :js }
      delete :clear_all, defaults: { format: :js }
    end
  end
end
