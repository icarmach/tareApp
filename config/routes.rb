TareApp::Application.routes.draw do
  resources :homeworks


  resources :archives


  resources :users

  root :to => 'home#index', :as => :home
  
	match 'logout' => 'home#logout', :as => :logout
	
	match 'search' => 'users#search', :as => :search

	match 'forgottenpassword' => 'users#forgottenpassword', :as => :forgottenpassword

	match 'changepassword' => 'users#changepassword', :as => :changepassword
end
