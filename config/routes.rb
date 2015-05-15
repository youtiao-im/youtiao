Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users

  namespace :api, shallow: true do
    api_version module: 'v1',
                header: { name: 'Accept',
                          value: 'application/vnd.youtiao.im+json; version=1' },
                path: { value: 'v1' },
                default: true do
      resource :user, only: [:show], controller: 'authenticated_users' do
        resources :memberships,
                  only: [:index],
                  controller: 'authenticated_users/memberships' do
          collection do
            get 'channels/:channel_id', action: :show
            put 'channels/:channel_id', action: :create
          end
        end

        resources :marks,
                  only: [:index],
                  controller: 'authenticated_users/marks' do
          collection do
            get 'feeds/:feed_id', action: :show
            put 'feeds/:feed_id', action: :create
            patch 'feeds/:feed_id', action: :update
          end
        end
      end

      resources :channels, only: [:show, :create] do
        resources :memberships,
                  only: [:index],
                  controller: 'channels/memberships' do
          collection do
            get 'users/:user_id', action: :show
            put 'users/:user_id', action: :create
          end
        end

        resources :feeds, only: [:index, :show, :create] do
          resources :marks, only: [:index], controller: 'feeds/marks' do
            collection do
              get 'users/:user_id', action: :show
            end
          end
        end
      end
    end
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
