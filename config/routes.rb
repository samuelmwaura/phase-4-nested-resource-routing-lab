Rails.application.routes.draw do
  resources :items, only: [:index]
  resources :users, only: [:show] do
    resources :items ,only: [:index,:show] #Means that within an individual user, we have a way to access all the items that are related to them and a singular item too.
    #It will produce the routes "users/:user_id/items" and "users/:user_id/items/:item_id"
  end


  resources :users,only: [:create] do #This is nesting for the item creation functionality
    resources :items, only: [:create]
 end
end
