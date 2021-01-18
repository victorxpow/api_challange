Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :accounts, only: [:create]do
      post :transfer, on: :member
      end
    end
  end
end