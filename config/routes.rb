Thamira::Application.routes.draw do

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  resources :eb_bills, only: [:index, :create, :update, :edit] do
    get "search", on: :collection
    get "export", on: :collection
    get 'print', on: :member
  end

  resources :courier_bills, only: [:index, :create, :update, :edit] do
    get "search", on: :collection
    get "export", on: :collection
    get 'print', on: :member
  end

  resources :payments_bills, only: [:index, :create, :update, :edit] do
    get "search", on: :collection
    get "export", on: :collection
    get 'print', on: :member
  end

  resources :cloths_bills, only: [:index, :create, :update, :edit] do
    get "search", on: :collection
    get "export", on: :collection
    get 'print', on: :member
  end

  resources :service_bills, only: [:index, :create, :update, :edit] do
    get "search", on: :collection
    get "export", on: :collection
    get 'print', on: :member
  end

  resources :ticket_bills, only: [:index, :create, :update, :edit] do
    get "search", on: :collection
    get "export", on: :collection
    get 'print', on: :member
  end

  resources :enquiries, only: [:index, :create, :update, :edit] do
    get "search", on: :collection
    get "export", on: :collection
    get 'print', on: :member
  end

  resources :billing_bills, only: [:index, :create, :update, :edit] do
    get "search", on: :collection
    get "export", on: :collection
    get 'print', on: :member
  end

  ActiveAdmin.routes(self)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'devise/sessions#new'
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
