Forgpresentation::Application.routes.draw do

  resources :discos

  resources :proyectos
  resources :fotos
  resources :videos
  
  match '/:id/fotos', :to => 'fotos#index', :as => 'index_fotos'
  match '/fotos/:id', :to => 'fotos#show', :as => 'show_foto'
  match '/fotos/:id/edit', :to => 'fotos#edit', :as => 'edit_foto'
  match '/fotos/:id/new', :to => 'fotos#new', :as => 'new_foto'  
  match '/videos/:id/new', :to => 'videos#new', :as => 'new_video'  
  match '/proyectos/:id/ver_proyecto', :to => 'proyectos#ver_proyecto', :as => 'ver_proyecto'
  match '/videos/:id/ver_video', :to => 'videos#ver_video', :as => 'ver_video'
  match '/fotos/:id/ver_galeria', :to => 'fotos#ver_galeria', :as => 'ver_galeria'
  match '/discos/:id/ver_catalogo', :to => 'discos#ver_catalogo', :as => 'ver_catalogo'
  match 'download' => 'proyectos#download';
	
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'proyectos#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
