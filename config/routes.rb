Break::Application.routes.draw do
  get "dashboard/index"
  get "event_importer/index"
  resources :places

  resources :events

  resources :profiles

  devise_for :user, :controllers => { :omniauth_callbacks => "user/omniauth_callbacks" } do
    delete '/user/disconnect/:provider', :to => 'user#disconnect_omniauth_provider', :as => 'disconnect_omniauth_provider'
    end
  root 'home#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

   get 'event_importer/:fb_eid/import_event' => 'event_importer#import_event', :as => 'import_event'

   post '/get_event_data' => 'home#get_event_data', :as => 'get_event_data'

   get 'city_events/:city' => 'home#get_city_events', :as => 'city_events'

   post '/:city/city_events_data' => 'home#city_events_data', :as => 'city_events_data'

   get '/dashboard/invitations' => 'dashboard#invitations', :as => 'user_invitations'


   post 'dashboard/:fb_eid/going' => 'dashboard#going', :as => 'going_event'

   post 'dashboard/:fb_eid/maybe' => 'dashboard#maybe', :as => 'maybe_event'

   post 'dashboard/:fb_eid/declined' => 'dashboard#declined', :as => 'declined_event'

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
