Minepropa::Application.routes.draw do

  resources :appunto_righe

  resources :libri

  devise_for :users
  
  resources :scuole do
    collection do
      post 'sort'
    end
    resources :indirizzi

  end
  
  resources :appunti do
    
    resources :visite
    resources :indirizzi

    get :autocomplete_scuola_nome_scuola, :on => :collection

    member do 
      get 'toggle_stato'
    end

    collection do
      post 'edit_or_print'
      post 'edit_multiple'
      get  'print_multiple', :format => 'pdf'
      put  'update_multiple'
      post  'delete_multiple'
    end
  end

  
  root :to => 'pages#home'
  
  match '/about',      :to => 'pages#about'
  match '/calendar',   :to => 'pages#calendar'
  match '/vendite',   :to => 'pages#vendite'
  
  post "versions/:id/revert" => "versions#revert", :as => "revert_version"
  
  put  "maps/:id/update_latlong"  => "maps#update_latlong",      :as => "update_latlong_maps"
  get  "maps/get_appunti_markers" => 'maps#get_appunti_markers', :as => 'get_appunti_markers_maps'  
  
  match 'maps/get_appunto_marker/:id' => 'maps#get_appunto_marker', :as => 'get_appunto_marker_maps'
  
  get 'visite' => 'visite#index'
  resources :indirizzi, :only => [:show, :update]
  
  resources :tags do
    collection do
      get 'appunti_cloud'
    end
  end
    
    
  
end
