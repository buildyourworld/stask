Rails.application.routes.draw do
  devise_for :users
  resources :recipes do
  	member do
  		post "add_info"
  	end
  end

  get "upvote_info/:id", to: "recipes#upvote_info", as: "upvote_info"
  get "downvote_info/:id", to: "recipes#downvote_info", as: "downvote_info"
  
  root "recipes#index"
end
