Rails.application.routes.draw do
  get 'project_entries/index'
  root 'project_entries#index'

  resources :project_entries do
    collection do
      get :search, defaults: { format: :json }
      get :default_search, defaults: { format: :json }
      delete :clear_all, defaults: { format: :json }
    end
  end
end
