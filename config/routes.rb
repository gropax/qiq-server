Rails.application.routes.draw do

  resources :notes, only: [:index, :show, :create, :update, :destroy]
  resources :tags, only: [:index, :show, :create, :update, :destroy]
  resources :buffers, only: [:index, :show, :create, :update, :destroy]

  post "notes/:id/tags", to: "notes#add_tag"
  delete "notes/:id/tags/:tag_id", to: "notes#remove_tag"

  post "buffers/:id/notes", to: "buffers#add_note"
  delete "buffers/:id/notes/:note_id", to: "buffers#remove_note"

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
