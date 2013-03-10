Mebel::Application.routes.draw do

  get "catalog/detail"

  devise_for :users

  match "ajax/:action" => "ajax"

  match "catalog" => "catalog#index"
  match "catalog/:category_id" => "catalog#category"
  match "catalog/:category_id/:product_id" => "catalog#product"

  match "basket" => "basket#index"
  match "basket/:action" => "basket"

  match "specials" => "special#index"
  match "howto" => "contact#index"
  match "contacts" => "contact#index"

  get "shopping_box/index"

  get "admin/index"

  match "admin" => "admin#index"
  match "admin/orders" => "admin#index"
  match "admin/orders/:id" => "admin#order"
  namespace :admin do
    match "ajax/:action" => "ajax"
    resources :textures do
      resources :kinds
    end
    resources :categories
    resources :specials
    resources :companies do
      resources :products
    end
  end



  get "catalog/list"

  get "catalog/index"

  get "special/index"

  get "contact/index"

  root :to => "index#index"

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
  #     # Direcs/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
