BetWithFriends::Application.routes.draw do

  get "bet/new"
  resources :players

  resources :crews

  root "home#index"

  resources :stages do
    resources :groups do
      resources :matches do
        member do
          get  'result'
          get  'result/edit' => 'matches#edit_result'
          put 'result' => 'matches#update_result'
          patch 'result' => 'matches#update_result'
        end
      end
      get 'teams'
      get 'standings' => 'standings#show'
      put 'standings' => 'standings#update'
      patch 'standings' => 'standings#update'
    end
  end

  resources :teams do
    get 'matches'
  end

  resources :crews do
    get 'players'
  end

  resources :players do
    resources :bets
  end






  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
