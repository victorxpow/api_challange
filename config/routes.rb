Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :accounts, only: [:create] 
      get 'accounts/balance/:account_number', to: 'accounts#balance'
      post 'accounts/transfer/:account_number', to: 'accounts#transfer'
    end
  end
end
