Brewtime::Application.routes.draw do
  resources :brews do
    resources :steps
  end
  
  root :to => 'brews#index'
end
