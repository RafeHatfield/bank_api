BankApi::Application.routes.draw do
  namespace :api, defaults: { format: :json }, path: '' do
    namespace :v1 do
      resources :accounts, only: [:show, :list]
      put '/accounts/withdraw/:amount', to: 'accounts#withdraw'
      post '/accounts/authenticate' => 'accounts#authenticate'
    end
  end
end
