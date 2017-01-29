Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users

  resources :products do
    get :who_bought, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'store/index', as: 'store_index'

  scope '(:locale)' do
    resources :orders
    resources :line_items do
      member do
        put 'decrement'
      end
    end
    resources :carts
    root 'store#index', as: 'store', via: :all
  end
end
