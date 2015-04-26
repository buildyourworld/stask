Rails.application.routes.draw do
  devise_for :users
  resources :recipes do
  	member do
  		post "add_info"
  		post "add_direction"
  	end
  end

  get "upvote_info/:id", to: "recipes#upvote_info", as: "upvote_info"
  get "downvote_info/:id", to: "recipes#downvote_info", as: "downvote_info"
  
  get "upvote_direction/:id", to: "recipes#upvote_direction", as: "upvote_direction"
  get "downvote_direction/:id", to: "recipes#downvote_direction", as: "downvote_direction"
  
  root "recipes#index"
end
