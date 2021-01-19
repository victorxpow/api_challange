require 'rails_helper'

RSpec.describe Api::V1::AccountsController, type: :controller do
  describe 'POST /api/v1/accounts' do
    context 'with valid attributes' do
      it 'create a new account' do
        name = Faker::Name.name
        token = Faker::Name.name
        balance = Faker::Number.number(digits: 3)
        account_number = Faker::Number.number(digits: 4)

        expect do
          post :create,
               params: { account: {
                 name: name,
                 balance: balance,
                 account_number: account_number,
                 token: token
               } }
        end.to change(Account, :count).by(1)

        expect(response.status).to eq(201)
        expect(JSON.parse(response.body)['name']).to eq(name)
        expect(JSON.parse(response.body)['balance']).to eq(balance)
        expect(JSON.parse(response.body)['account_number'].nil?).to eq(false)
      end
    end

    context 'when the account number alredy taken' do
      it 'show the account number and message error' do
        account = create(:account)

        post :create,
             params: { account: {
               account_number: account.account_number
             } }

        expect(response.status).to eq(409)
        expect(JSON.parse(response.body)['message']).to eq('Account number already taken')
        expect(JSON.parse(response.body)['account_number']).to eq(account.account_number)
      end
    end
  end

  describe 'POST /api/v1/accounts/transfer' do
    context 'with valid attributes' do
      it 'sucessfully transaction' do
        account = create(:account, balance: 100)
        destination_account = create(:account, balance: 100)

        post :transfer,
             params: {
               account_number: account.account_number,
               destination_account_number: destination_account.account_number,
               amount: 10
             }

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['message']).to eq('Successfully transaction!')
        expect(account.reload.balance).to eq(90)
      end
    end
  end

  describe 'GET /api/v1/accounts/balance' do
    context 'with valid attributes' do
      it 'show the balance' do
        account = create(:account, balance: 1000)

        get :balance, params: { account_number: account.account_number }

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(account.balance)
      end
    end
  
    context 'when account doesnt exist' do
      it 'show error message' do
        get :balance, params: { account_number: 465489 }

        expect(response.status).to eq(404)
        expect(JSON.parse(response.body)['message']).to eq('Account doesnt exist')
      end
    end
  end
end
